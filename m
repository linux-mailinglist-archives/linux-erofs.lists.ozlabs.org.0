Return-Path: <linux-erofs+bounces-2881-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GMXE6o9vWmJ8AIAu9opvQ
	(envelope-from <linux-erofs+bounces-2881-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 13:29:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2D2DA3F0
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 13:29:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fchhQ4fDSz2yYY;
	Fri, 20 Mar 2026 23:29:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774009766;
	cv=none; b=izyIt6GG9eDMWUwB12kjqjtJODi4ditfHV3iXEEdJ3IqiSgJtBYurZ4YRMmztCSvMJ8NjoXNZRbsyYsTZnK2pslgQspgJtJ8ay+Rh90cVPUMj8im2fRFi2/P77ETJgHYqptEmR3BPHC/+sVZx+Cl3pYq/YaKm+nCzIM7kDuTt4gAgGa6F1gvIae/m9g2QiV2jthxuFwf/V83vpcmLQLfnrFkeDn9TKP1uiH6/UaIUFXJkgEFpFmMyZ8s8lfJXd4fULwftUVXLXhLN4jO18Ucyf2m4IvsJe2YbyIkfIE37V6Hgo54lSvpZWdARr5vezrG0I+JWuqC5qRKmWgLyAsoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774009766; c=relaxed/relaxed;
	bh=Py9dQG34+cgMso0dXF7GsCnnqB5bfyHvTV9BR0i/BXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpGDutHHrAZZJSZklYe/k4+LayoHQut0+XAaPIGD3a/yQ+TvUCdVZHQfSU7hzjFXXuX/E3LdtpSU7e41+nzFqK4jZZ8cmR05kLnLOguQbCgPizKhM6iNLQXriSIGtitAIqQgzZdXlFzjUmMFgQ/adVNQy2jzMfu+3ltDGetKujeDBvNZJIGdmajE0rmEnlEsIgbc3plKCSuI5s2Q+TJah8x/PQ7ePF4qMiyw/sQrPcMEZ8ImlCUZ/71uiZheazPqG0N3Z1qwbBWFxuw1Lq076ZearrCzHdhIAmDCv/5Y4VlEkOqdQv40+q2eBeR2y2oxB0upy1QZ4LoZy692y9pEfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FFxtIMEJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FFxtIMEJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fchhP1931z2yY9
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 23:29:24 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so273929566b.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774009761; x=1774614561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Py9dQG34+cgMso0dXF7GsCnnqB5bfyHvTV9BR0i/BXo=;
        b=FFxtIMEJ1Akcoql5wxyrSrXVYmde52srhIuTI0QOCMRxNXI3fP9VmibRla8zlr/1Er
         0HP57kL2AzN2rkfnaRUD98kMKrbDjxHsCIYIwNL5V3WuVADvqvC/ldS8EaMLyBuNf5U2
         pTJk4Bz0+emh1oUo0BZGLGfP5pda8gYxUHnJwaGWmqyHbV3AbA4QWxQ7+763K37cLTMn
         ZHQPx7uoAFhQjMQZXzN7PhOxsNsf0CufHNhgT7NevLHKtM8yRfy0/bdC9nOAueXeNz3Q
         HfrPtbJqdrvft5VMju2SK2EwkDhdPAE8CAL09BK02pJgcXxzFbGvjHAk3tyqcEqaF4IN
         I1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774009761; x=1774614561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py9dQG34+cgMso0dXF7GsCnnqB5bfyHvTV9BR0i/BXo=;
        b=qU6jb/FeqYNw/PHA4uqnED61sGhiX0W6GolHBpdILJxKdV0hS8QgNlJEOeZFS77vou
         1I02aE4+aBQwh0jbaTkKyqGESQSFzA91q59gZDSlBpy/9Cbnl2pt0eCZ4dmsRImeQ655
         7aWK74mrv4gEyVK1u7asIoZfmvMxsi847v13Q6Ts2Gepl9D+5ugRZyRllYB1Gj6THupw
         H8EZO13Gv7gvBz5aWqAjEIv2geWdhAAXxJ4v7i2TGjBU4K8Pn6MrsO+wzTYn22Gy+71R
         QKK955JLqlm49q0CMrSBtvgCV2m3iPN+gphOMtILQfLdShl5Vhu/oN0s0rh6BH6+ARaX
         K6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKymYTJSgYAjIyAFMMO7Ti+08rwtzH2h8ZpZgdTrwXeFANgr9XpjEm9uUS+KF3fYYemHcKHgM9UBXXBA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyL37wjjRWg5iI+d3rMpzYozJ5029+KBEzgyIYMwOCMup+Oih94
	t+s/Xd8DuS/9d1MOQ9P5YQ8XO6r7DxmWd3iZWcnDccjHskdtkBFacCUE
X-Gm-Gg: ATEYQzyqWkuGCc98oVOgJOGvppk3hCObEJXGx62oucVsFyej+otVEmHURBZDgs+w523
	PDqyfwTb+Abm447Me6IrvkawbTgXViR67TURivEYT5ylA+w10weuOBkYzo2t56gSaiWFObKIh3K
	GgfECISX1XAHx1J1cPbtI0M9qvURePdOQxyKFQC8kDWyEQpM3z+ThtyimPVACmLJ3HpsSor5Ead
	hChKixFPUxq5fE+KFOVtNXBWCHVJJGBBV1YeTXefMdUV7U5/FbR/zp0bSRbImbWe3scypPIHVV7
	qnH7zPcmE6CUs4TLyDqQJLlX/eTgD1GFh860pUgsTxyOYEPShHhrx5dJT1v2ZTc3gE2Uk685tn+
	hrYUbN4BmbXLGtzcm+jGlUtM9eu99wTv5L4CVKWhaiI6hJR66M/h0E7CnNTeYn2lzSaetoiaZgl
	IRbMA3Hu+YWbu0Osd59x4y4f34+M7X40xa0xdFhEI8RjoWJX9V74v+LPKRA/SON7/vJ52hJsF31
	9lcKghhgYgnXk1AEDHZUUTkvnpXWiNm066m3f4=
X-Received: by 2002:a17:907:e11a:b0:b96:edcd:cd19 with SMTP id a640c23a62f3a-b982f502793mr138927666b.50.1774009760240;
        Fri, 20 Mar 2026 05:29:20 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-e98d-b8f7-8d95-53b2.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:e98d:b8f7:8d95:53b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f42f0dsm154218566b.12.2026.03.20.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:29:19 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Paul Moore <paul@paul-moore.com>,
	Gao Xiang <xiang@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Subject: [PATCH v2] fs: allow backing file code to open an O_PATH file with negative dentry
Date: Fri, 20 Mar 2026 13:29:18 +0100
Message-ID: <20260320122918.1726043-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2881-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:paul@paul-moore.com,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 5ED2D2DA3F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fields f_mapping and f_wb_err are irrelevant for the O_PATH file
in backing_file_user_path_file().

Create a dedicated helper kernel_path_file_open(), which skips all the
generic code in do_dentry_open() and does only the essentials, so that
the internal O_PATH file could be opened with a negative dentry.

This is needed for backing_tmpfile_open() to open a backing O_PATH
tmpfile before instantiating the dentry.

The callers of backing_tmpfile_open() are responsible for calling
backing_tmpfile_finish() after making the path positive.

Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This patch fixes the syzbot report [1] that the
backing_file_user_path_file() patch [2] introduces.

Following your feedback on v1, this version makes an effort to stay
out of the way of main vfs execution paths and restrict the changes
to backing_file users.

This still introduced a temporary state of an O_PATH file with negative
path, but only for a short time and only for backing_file users and
ones that use backing_tmpfile_open() (i.e. only overlayfs), so the
risk is minimal.

WDYT?

Thanks,
Amir.

Changes since v1:
- Create helper for internal O_PATH open with negative path
- Create backing_tmpfile_finish() API to fixup the negative path

[1] https://syzkaller.appspot.com/bug?extid=f34aab278bf5d664e2be
[2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73il@gmail.com/

 fs/backing-file.c            |  6 ++++++
 fs/file_table.c              | 14 ++++++++++++--
 fs/internal.h                |  7 +++++++
 fs/open.c                    | 34 ++++++++++++++++++++++++++++++----
 fs/overlayfs/dir.c           |  2 ++
 include/linux/backing-file.h |  1 +
 6 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index d0a64c2103907..3357d624eac96 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -80,6 +80,12 @@ struct file *backing_tmpfile_open(const struct path *user_path,
 }
 EXPORT_SYMBOL(backing_tmpfile_open);
 
+void backing_tmpfile_finish(struct file *file)
+{
+	backing_file_set_user_path_inode(file);
+}
+EXPORT_SYMBOL_GPL(backing_tmpfile_finish);
+
 struct backing_aio {
 	struct kiocb iocb;
 	refcount_t ref;
diff --git a/fs/file_table.c b/fs/file_table.c
index e8b4eb2bbff85..a4d1064d50896 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -69,11 +69,21 @@ EXPORT_SYMBOL_GPL(backing_file_user_path_file);
 
 int backing_file_open_user_path(struct file *f, const struct path *path)
 {
-	/* open an O_PATH file to reference the user path - should not fail */
-	return WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
+	if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
+		return -EIO;
+	kernel_path_file_open(&backing_file(f)->user_path_file, path);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(backing_file_open_user_path);
 
+void backing_file_set_user_path_inode(struct file *f)
+{
+	if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
+		return;
+	file_set_d_inode(&backing_file(f)->user_path_file);
+}
+EXPORT_SYMBOL_GPL(backing_file_set_user_path_inode);
+
 static void destroy_file(struct file *f)
 {
 	security_file_free(f);
diff --git a/fs/internal.h b/fs/internal.h
index 7c44a58627ba3..4a9e5e00678d9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -109,6 +109,13 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
 				      const struct cred *user_cred);
 int backing_file_open_user_path(struct file *f, const struct path *path);
+void backing_file_set_user_path_inode(struct file *f);
+void kernel_path_file_open(struct file *f, const struct path *path);
+
+static inline void file_set_d_inode(struct file *f)
+{
+	f->f_inode = d_inode(f->f_path.dentry);
+}
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/open.c b/fs/open.c
index 91f1139591abe..a7b3b04cd9ae7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -884,10 +884,38 @@ static inline int file_get_write_access(struct file *f)
 	return error;
 }
 
+static const struct file_operations empty_fops = {};
+
+static void do_path_file_open(struct file *f)
+{
+	f->f_mode = FMODE_PATH | FMODE_OPENED;
+	file_set_fsnotify_mode(f, FMODE_NONOTIFY);
+	f->f_op = &empty_fops;
+}
+
+/**
+ * kernel_path_file_open - open an O_PATH file for kernel internal use
+ * @f:		pre-allocated file with f_flags and f_cred initialized
+ * @path:	path to reference (may have a negative dentry)
+ *
+ * Open a minimal O_PATH file that only references a path.
+ * Unlike vfs_open(), this does not require a positive dentry and does not
+ * set up f_mapping and other fields not needed for O_PATH.
+ * If path is negative at the time of this call, the caller is responsible for
+ * callingn backing_file_set_user_path_inode() after making the path positive.
+
+ */
+void kernel_path_file_open(struct file *f, const struct path *path)
+{
+	f->__f_path = *path;
+	path_get(&f->f_path);
+	file_set_d_inode(f);
+	do_path_file_open(f);
+}
+
 static int do_dentry_open(struct file *f,
 			  int (*open)(struct inode *, struct file *))
 {
-	static const struct file_operations empty_fops = {};
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
@@ -898,9 +926,7 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED;
-		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
-		f->f_op = &empty_fops;
+		do_path_file_open(f);
 		return 0;
 	}
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 5fd32ccc134d2..4010c87e10196 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1408,6 +1408,8 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			err = ovl_instantiate(dentry, inode, newdentry, false, file);
 			if (!err) {
 				file->private_data = of;
+				/* user_path_file was opened with a negative path */
+				backing_tmpfile_finish(realfile);
 			} else {
 				dput(newdentry);
 				ovl_file_free(of);
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 8afba93f3ce07..52ac51ada6ff9 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -47,6 +47,7 @@ struct file *backing_tmpfile_open(const struct path *user_path,
 				  const struct cred *user_cred, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred);
+void backing_tmpfile_finish(struct file *file);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx);
-- 
2.53.0


