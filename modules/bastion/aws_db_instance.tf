#----------------------------------------
# RDS parameter group
#----------------------------------------
resource "aws_db_parameter_group" "mysql_parameter_group" {
  name = "${var.env}-${var.service}-mysql-param-standalone"
  family = "mysql8.0"

  # データベースに設定するパラメーター
  parameter {
    name = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name = "character_set_server"
    value = "utf8mb4"
  }
}

#----------------------------------------
# RDS option group
#----------------------------------------
resource "aws_db_option_group" "mysql_option_group" {
  name = "${var.env}-${var.service}-mysql-option-standalone"
  engine_name = "mysql"
  major_engine_version = "8.0"
}

#----------------------------------------
# RDS subnet group
#----------------------------------------
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name = "${var.env}-${var.service}-mysql-subnet-standalone"
  # subnetの設定
  subnet_ids = [
    # subnetの設定(01_networkのoutputs.tfの情報を利用)　
    aws_subnet.pri_1a.id,
    aws_subnet.pri_1c.id,
    aws_subnet.pri_1d.id,
  ]
  tags = {
     Name = "${var.env}-${var.service}-mysql-option-standalone"
     Project = "${var.service}"
     Env = "${var.env}"
  }
}

resource "random_string" "db_password" {
  length = 16
  special = false
}

# DBの作成(前回の作成時間：8m10s、削除時間：3m55s)
resource "aws_db_instance" "mysql_standalone" {
  # 使用するDBを設定
  engine = "mysql"
  # 使用するDBのバージョンを設定
  engine_version = "8.0"

  # dbの名前（任意）
  identifier = "${var.env}-${var.service}-mysql-standalone"
  # dbユーザー名
  username = "admin"
  # パスワード。上記で生成したランダムな文字列を設定
  password = random_string.db_password.result
  # インスタンスクラスの設定
  instance_class = "db.t2.micro"

  # ストレージの大きさ。デフォルトのサイズ（GB）を設定
  allocated_storage = 20
  # ストレージの自動拡張サイズ（GB）を設定
  max_allocated_storage = 50
  # ストレージタイプ。デフォルトはgp2
  storage_type = "gp2"
  # ストレージの暗号化を行うかどうか設定
  storage_encrypted = false


  # マルチAZの設定を行うかどうか設定する
  multi_az = false
  # マルチAZを行わない場合は、DBの配置先を指定する
  availability_zone = "ap-northeast-1a"
  # サブネットグループを設定する(上記で作成したもの)
  db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
  # セキュリティグループの設定をする(01_networkのoutputs.tfの情報を利用)
  vpc_security_group_ids = [ aws_security_group.rds_bastion_sg.id ]
  # publicアクセスを許可するか設定
  publicly_accessible = false
  # ポート番号を設定
  port = 3306


  # データベース名を設定
#   name = "labDB"
  # パラメーターグループ名を設定（上記で作成したもの）
  parameter_group_name = aws_db_parameter_group.mysql_parameter_group.name
  # オプショングループ名を設定（上記で作成したもの）
  option_group_name = aws_db_option_group.mysql_option_group.name


  # -- DBの管理設定。maintenance_windowは、backup_windowの後の時間に設定する
  # バックアップを行う時間を設定
  backup_window = "04:00-05:00"
  # バックアップの保存期間（日）を設定
  backup_retention_period = 0
  # DBインスタンスまたはクラスターのエンジンバージョンの更新、OS更新があった場合に更新作業を行う時間を設定
  maintenance_window = "Mon:05:00-Mon:08:00"
  # 自動的にDBのマイナーバージョンアップグレードを行うか設定する
  auto_minor_version_upgrade = false


  # -- 削除設定
  # 削除操作を受付るかを指定。削除させない場合はtrue
  deletion_protection = false
  # インスタンス削除時にスナップショットをとるかを設定
  skip_final_snapshot = true
  # DBインスタンスが削除されたときに保存するスナップショットの名前 skip_final_snapshot = falseの時に指定
  final_snapshot_identifier = "final-snapshot-lab"
  # データベースの変更をすぐに適用するか、次のメンテナンスウィンドウ中に適用するかを指定する
  apply_immediately = true


  # -- タグの設定
  tags = {
     Name = "${var.env}-${var.service}-mysql-option-standalone"
     Project = "${var.service}"
     Env = "${var.env}"
  }
}