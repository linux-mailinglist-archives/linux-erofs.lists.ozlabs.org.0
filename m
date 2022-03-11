Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161054D5975
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 05:17:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFCMR6HbFz30BM
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 15:17:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646972259;
	bh=SdHatth0q/4cnw+nQWn3RsPm8L+NKYlptQNznoRJW9k=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=PNywEemPzOGjggCXTRFFQmL2ZCUfvkWA/0/R05G5Hb/5QI7eTrDlAmoX3jC44ZdI0
	 aTtIQvQu1MRIJdA6IjgxGYi5ZHpX7toQkdg/qegBg+ZW6pyFZYEl/L+xGU16rk3Ost
	 k+crcC0cSSGMSsoeknGAX67GVHshBU5iG/BcPQNrIT4kjRbjgtsjyzOMpStLniXc3R
	 sil2QCOxHA4c2/c6o1nwBEXHtCesoAQt40jT3t2d0tsnoIOGuhRJjf0gfXNyuiX8yC
	 kbGgujOSZENEk9Ud/tGp08tmY/T4k7OZkF8DQOsh6pPyKb3wnql8etc3u02BI2qNO9
	 7KIbnvbQZGe9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com;
 envelope-from=3wm0qygckc7uyqviyzmbjjbgz.xjhgdips-zmjangdnon.jugvwn.jmb@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=H8kfHMQs; dkim-atps=neutral
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFCMK1YMDz2xTq
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 15:17:31 +1100 (AEDT)
Received: by mail-pl1-x64a.google.com with SMTP id
 z10-20020a170902708a00b0014fc3888923so3873447plk.22
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 20:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=SdHatth0q/4cnw+nQWn3RsPm8L+NKYlptQNznoRJW9k=;
 b=v6YZ/FmYLZWfTXx33wk6S+3WdIIhPer75qVC1xKmTr6zaZUK2rM2crj6KEBLM4/A9s
 A1fx3MbkvrnhHa0nN78I25PlYkEPzs22y6cJyZ/WhxlXK1cR33yaEyRmCO0QCkYKFn0y
 gkNWjAXJWjlfWXS919AeRYCtijqDr32AqjIvCvQjOV7fDoUF6tty2o7jv7p5YNgopTc5
 4616DG5/EIj47rv4penVe1Mv6Rxr/JGSphSud/3A7jfccsv196ZOhy2oOj6pgINIZXoL
 x4Sr+sUPz6IkD3a8HoPisJhcHPpwRc4yOfePCljc1wZRQo9jkywax/wfh0DLJZmA8/iE
 VOOA==
X-Gm-Message-State: AOAM531pENxGePKQpnfzZ09NgpBAfcjkBM8cR8jD4THH1reGHaC4Twwg
 JxxylZXf3okslk5hQX2ltej+6uxdmklQT7nSwsRrsOuPWFyfTFZLa6LMTDGO8eVMy1Mjj5mhX/o
 Uc3ufXzBjMNTw5NbyWcsWDcFpAIM9jerBT1JMsM6c9a0lEnd7pQmlYo3ZI6Y03bPuNrAIqXoF
X-Google-Smtp-Source: ABdhPJwds4gTTBvmOVPfGH2PtyBtP2MJge043yADZC5dbqaiYSa6b7lnojOsUi5vTFPRrCkZufTmGKu0VDv9
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5102])
 (user=dvander job=sendgmr) by 2002:a17:902:ecd0:b0:151:dd64:c79b with SMTP id
 a16-20020a170902ecd000b00151dd64c79bmr8640005plh.79.1646972248278; Thu, 10
 Mar 2022 20:17:28 -0800 (PST)
Date: Fri, 11 Mar 2022 04:17:23 +0000
Message-Id: <20220311041724.3107622-1-dvander@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 1/2] erofs-utils: mkfs: rename ctime to mtime
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently mkfs.erofs picks up whatever the system time happened to be
when the input file structure was created. Since there's no (easy) way for
userspace to control ctime, there's no way to control the per-file ctime
that mkfs.erofs uses.

In preparation for switching to mtime, rename the "ctime" members of the
inode structure.

Signed-off-by: David Anderson <dvander@google.com>
---
 dump/main.c              |  4 ++--
 fsck/main.c              | 12 ++++++------
 fuse/main.c              |  2 +-
 include/erofs/internal.h |  4 ++--
 include/erofs_fs.h       |  4 ++--
 lib/inode.c              | 14 +++++++-------
 lib/namei.c              |  8 ++++----
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index bb1bd7f..6565d35 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -488,7 +488,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	}
 
 	strftime(timebuf, sizeof(timebuf),
-		 "%Y-%m-%d %H:%M:%S", localtime((time_t *)&inode.i_ctime));
+		 "%Y-%m-%d %H:%M:%S", localtime((time_t *)&inode.i_mtime));
 	access_mode = inode.i_mode & 0777;
 	for (i = 8; i >= 0; i--)
 		if (((access_mode >> i) & 1) == 0)
@@ -507,7 +507,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	fprintf(stdout,	"Xattr size: %u\n", inode.xattr_isize);
 	fprintf(stdout, "Uid: %u   Gid: %u  ", inode.i_uid, inode.i_gid);
 	fprintf(stdout, "Access: %04o/%s\n", access_mode, access_mode_str);
-	fprintf(stdout, "Timestamp: %s.%09d\n", timebuf, inode.i_ctime_nsec);
+	fprintf(stdout, "Timestamp: %s.%09d\n", timebuf, inode.i_mtime_nsec);
 
 	if (!dumpcfg.show_extent)
 		return;
diff --git a/fsck/main.c b/fsck/main.c
index e669b44..0af15b4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -229,14 +229,14 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 
 #ifdef HAVE_UTIMENSAT
 	if (utimensat(AT_FDCWD, path, (struct timespec []) {
-				[0] = { .tv_sec = inode->i_ctime,
-					.tv_nsec = inode->i_ctime_nsec },
-				[1] = { .tv_sec = inode->i_ctime,
-					.tv_nsec = inode->i_ctime_nsec },
+				[0] = { .tv_sec = inode->i_mtime,
+					.tv_nsec = inode->i_mtime_nsec },
+				[1] = { .tv_sec = inode->i_mtime,
+					.tv_nsec = inode->i_mtime_nsec },
 			}, AT_SYMLINK_NOFOLLOW) < 0)
 #else
-	if (utime(path, &((struct utimbuf){.actime = inode->i_ctime,
-					   .modtime = inode->i_ctime})) < 0)
+	if (utime(path, &((struct utimbuf){.actime = inode->i_mtime,
+					   .modtime = inode->i_mtime})) < 0)
 #endif
 		erofs_warn("failed to set times: %s", path);
 
diff --git a/fuse/main.c b/fuse/main.c
index 2549d8a..ae377ae 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -98,7 +98,7 @@ static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_gid = vi.i_gid;
 	if (S_ISBLK(vi.i_mode) || S_ISCHR(vi.i_mode))
 		stbuf->st_rdev = vi.u.i_rdev;
-	stbuf->st_ctime = vi.i_ctime;
+	stbuf->st_ctime = vi.i_mtime;
 	stbuf->st_mtime = stbuf->st_ctime;
 	stbuf->st_atime = stbuf->st_ctime;
 	return 0;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 947304f..56627e9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -154,8 +154,8 @@ struct erofs_inode {
 	u64 i_ino[2];
 	u32 i_uid;
 	u32 i_gid;
-	u64 i_ctime;
-	u32 i_ctime_nsec;
+	u64 i_mtime;
+	u32 i_mtime_nsec;
 	u32 i_nlink;
 
 	union {
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9a91877..e01f5c7 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -183,8 +183,8 @@ struct erofs_inode_extended {
 
 	__le32 i_uid;
 	__le32 i_gid;
-	__le64 i_ctime;
-	__le32 i_ctime_nsec;
+	__le64 i_mtime;
+	__le32 i_mtime_nsec;
 	__le32 i_nlink;
 	__u8   i_reserved2[16];
 };
diff --git a/lib/inode.c b/lib/inode.c
index 461c797..24f2567 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -477,8 +477,8 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		u.die.i_uid = cpu_to_le32(inode->i_uid);
 		u.die.i_gid = cpu_to_le32(inode->i_gid);
 
-		u.die.i_ctime = cpu_to_le64(inode->i_ctime);
-		u.die.i_ctime_nsec = cpu_to_le32(inode->i_ctime_nsec);
+		u.die.i_mtime = cpu_to_le64(inode->i_mtime);
+		u.die.i_mtime_nsec = cpu_to_le32(inode->i_mtime_nsec);
 
 		switch (inode->i_mode & S_IFMT) {
 		case S_IFCHR:
@@ -806,16 +806,16 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_mode = st->st_mode;
 	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
 	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
-	inode->i_ctime = st->st_ctime;
-	inode->i_ctime_nsec = ST_CTIM_NSEC(st);
+	inode->i_mtime = st->st_ctime;
+	inode->i_mtime_nsec = ST_CTIM_NSEC(st);
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
-		if (st->st_ctime < sbi.build_time)
+		if (inode->i_mtime < sbi.build_time)
 			break;
 	case TIMESTAMP_FIXED:
-		inode->i_ctime = sbi.build_time;
-		inode->i_ctime_nsec = sbi.build_time_nsec;
+		inode->i_mtime = sbi.build_time;
+		inode->i_mtime_nsec = sbi.build_time_nsec;
 	default:
 		break;
 	}
diff --git a/lib/namei.c b/lib/namei.c
index 7377e74..2c8891a 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -79,8 +79,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_gid = le32_to_cpu(die->i_gid);
 		vi->i_nlink = le32_to_cpu(die->i_nlink);
 
-		vi->i_ctime = le64_to_cpu(die->i_ctime);
-		vi->i_ctime_nsec = le64_to_cpu(die->i_ctime_nsec);
+		vi->i_mtime = le64_to_cpu(die->i_mtime);
+		vi->i_mtime_nsec = le64_to_cpu(die->i_mtime_nsec);
 		vi->i_size = le64_to_cpu(die->i_size);
 		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
 			/* fill chunked inode summary info */
@@ -114,8 +114,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_gid = le16_to_cpu(dic->i_gid);
 		vi->i_nlink = le16_to_cpu(dic->i_nlink);
 
-		vi->i_ctime = sbi.build_time;
-		vi->i_ctime_nsec = sbi.build_time_nsec;
+		vi->i_mtime = sbi.build_time;
+		vi->i_mtime_nsec = sbi.build_time_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
 		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
-- 
2.35.1.723.g4982287a31-goog

