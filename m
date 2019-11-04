Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B77ED745
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 02:47:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 475wdy6PBKzF38D
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 12:47:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=vt.edu
 (client-ip=2607:b400:92:8400:0:33:fb76:806e; helo=omr2.cc.vt.edu;
 envelope-from=valdis@vt.edu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=vt.edu
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu
 [IPv6:2607:b400:92:8400:0:33:fb76:806e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475wdj6BKCzF26V
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Nov 2019 12:47:03 +1100 (AEDT)
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu
 [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
 by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kuDU010101
 for <linux-erofs@lists.ozlabs.org>; Sun, 3 Nov 2019 20:46:57 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kpiR026635
 for <linux-erofs@lists.ozlabs.org>; Sun, 3 Nov 2019 20:46:56 -0500
Received: by mail-qk1-f199.google.com with SMTP id a186so13949105qkb.18
 for <linux-erofs@lists.ozlabs.org>; Sun, 03 Nov 2019 17:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=r7c0I8SvMYKpHRjqYv9HI6yFzb55f/VPo02TJ216c5Q=;
 b=VTwObiqQKUYOBpOxTHc00PPjC3huLFnzQ/gImCqfV4asarFHwXF3JA3btI+Rod0oZ/
 yQ843Kg98v9o01Yy/eMY0I5gYGApLi0qqHFtFpNFJJBQnSijEmBOm5MUT0s5vwpmik2i
 UghttixeaKqZ5AmQOW3QFBo2BpsWzWjeaK5hyFgcySKCnYmDDH/elnb9zvAPKzg0SP30
 mCJj0G3TlWTBovQFMxXrJURI85Ckd6XInRUxLT5c3/iyvjfGoHURvbCXrzyB/UDwdTfW
 S9Eglex8/gq0JzrroHbL84AVYD498OQifLHQGow05dPnNOHlap/tgE0/WM3TAZj7ENDl
 CwjA==
X-Gm-Message-State: APjAAAX+CrHfgJE9e+vxQfPHWS5BBXfwNBye89xNHwZ2ydWthxu5iCCN
 i4xVX7Iy0XiyFl+gpH71qEEPbRNzWd1zjQEjljVAi/W1yaNyGjLo5YuWB5xDpSTS5a4+oquAzcT
 TJEioCJ45mESdC33MgDEqDWP3561P90lH8js=
X-Received: by 2002:a05:6214:70f:: with SMTP id
 b15mr19848533qvz.97.1572832010214; 
 Sun, 03 Nov 2019 17:46:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ6TMTqkBpyXQGPAZMIMj5EH3dwBQ8r4Ftf0xofxFI/BWghZasoJHnZlzuhtG3wrll2Arcjw==
X-Received: by 2002:a05:6214:70f:: with SMTP id
 b15mr19848512qvz.97.1572832009874; 
 Sun, 03 Nov 2019 17:46:49 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
 by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2019 17:46:49 -0800 (PST)
From: Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
Date: Sun,  3 Nov 2019 20:45:06 -0500
Message-Id: <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: devel@driverdev.osuosl.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
 linux-arch@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Gao Xiang <xiang@kernel.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There's currently 6 filesystems that have the same #define. Move it
into errno.h so it's defined in just one place.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/staging/exfat/exfat.h    | 2 --
 fs/erofs/internal.h              | 2 --
 fs/ext4/ext4.h                   | 1 -
 fs/f2fs/f2fs.h                   | 1 -
 fs/xfs/xfs_linux.h               | 1 -
 include/linux/jbd2.h             | 1 -
 include/uapi/asm-generic/errno.h | 1 +
 7 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 72cf40e123de..58b091a077e8 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -30,8 +30,6 @@
 #undef DEBUG
 #endif
 
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
-
 #define DENTRY_SIZE		32	/* dir entry size */
 #define DENTRY_SIZE_BITS	5
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076..3980026a8882 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -425,7 +425,5 @@ static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
-#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..a86c2585457d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3396,6 +3396,5 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _EXT4_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4024790028aa..04ebe77569a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3752,6 +3752,5 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index ca15105681ca..3409d02a7d21 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -123,7 +123,6 @@ typedef __u32			xfs_nlink_t;
 
 #define ENOATTR		ENODATA		/* Attribute not found */
 #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 
 #define SYNCHRONIZE()	barrier()
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 603fbc4e2f70..69411d7e0431 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1657,6 +1657,5 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _LINUX_JBD2_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..1d5ffdf54cb0 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -98,6 +98,7 @@
 #define	EINPROGRESS	115	/* Operation now in progress */
 #define	ESTALE		116	/* Stale file handle */
 #define	EUCLEAN		117	/* Structure needs cleaning */
+#define	EFSCORRUPTED	EUCLEAN
 #define	ENOTNAM		118	/* Not a XENIX named type file */
 #define	ENAVAIL		119	/* No XENIX semaphores available */
 #define	EISNAM		120	/* Is a named type file */
-- 
2.24.0.rc1

