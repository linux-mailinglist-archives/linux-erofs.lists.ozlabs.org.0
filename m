Return-Path: <linux-erofs+bounces-2941-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIaQEL7AwGmfKgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2941-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 05:25:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCE92EC6EF
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 05:25:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffKpd4PH1z2yYq;
	Mon, 23 Mar 2026 15:25:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774239929;
	cv=none; b=ccFU7ThmRI51tzdYZNf/DE8+x5StYfIoMUhnwVI5wBs2faf6202J0j0+Hm5XtQS7PXB5ry6VWRhOoCRVvPsNKAGqclA5X21U3J4bFb4W70yoL8AXqfoampEEwpiqLePMrOAreyenQd04VAAbzpEAd/HR1JRrfr0uvmzC8iKgoR94b7Wtw3U2/3pfK83r+MVKkjA9XD13WngeV2elcunB7V97FRyRVeKeGxMJLp6eiUR9JfA4opSyHB3Xeh/WbI5Z+j5McRc02L+PVhHg2/95H9SCEttf7fsKgBHyhvusLa5aNxxoQYP7cqjTCS8BC6udJWFVwbJAkPQQKldqPhGYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774239929; c=relaxed/relaxed;
	bh=Vdp43HB6WjcpLmiqaAcEQQIdwROMo8yja+YUS4mYj7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmgEfX4AlQ7BR/yOMbvl+ubV5dhHz1QEDkb/jq8OxRT/rVWsn/vOgUv4YR18s3kgKt6ZPUPdsdonC0VOJI3U7fuorMAlJbwQHT6wZ4mK5y7Jsr5irfWFYWSQfpBZvIaq45y+lDCtlGifIdbqeAj+Ckmp1ETYi8RTslL7/nfe6li/N7JmsUDL1Q7jKmEYFDSvJqMb07fconOkPeM/j3nCa+aP9CL6cnKqFOAyn6g53GNchuKszUEXKn4A5UOaYxys37/KNn5VSBAk3QMU0vZmP3S+WgMWkSjejmykkefnhhI2TNCNGsIPMgtkViDo5o7S9pEVsO3qR7mxOw/oxQ8l0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IkTMu0q5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IkTMu0q5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffKpb1MH3z2ySb
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 15:25:26 +1100 (AEDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-50b2ebca625so31933041cf.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774239924; x=1774844724; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdp43HB6WjcpLmiqaAcEQQIdwROMo8yja+YUS4mYj7A=;
        b=IkTMu0q5emLAJbLEfYjgGEYzRdyqxomSiFcBv0klQaXNeFJ9xIloEdLFYsRm6XvIUl
         +7LAKOcWT8VvstF+pys12bTkcmGEVtav0LrKcYHy+0rjCvplw8t2QwvVtgCb+51ECSpj
         5s8wfaHJxk30VaTsc+TafqMxKHXxMvJ43JkTTZ+oaOef6CpFUPB8zxJkf/G0aWHNUmXV
         GfGM86suxZq93wH4S6xB+CDCfnrJW7eHsK63if70ez/440SrOpUfsEzi4bLpcOcBWADR
         +6T0tmAV0JFX8qAfSCqxwUTZrVgWGyvjOjABj+aKvtF1noTwigC+fdtVUgh/WNaS4XSA
         rynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774239924; x=1774844724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vdp43HB6WjcpLmiqaAcEQQIdwROMo8yja+YUS4mYj7A=;
        b=g9+EPytzZJkHTNhTsNL6O0d9Y5b7Nfwn9kvenBQjdk54Ns3rO204MFFCQdP+ahp3dE
         N8ZBugB7Ge+bMTfslx7wgCUi1jORRpQup65/03KZbXAfNZFmJBizCqQXR4lWC8Ye5QTC
         QUQoFwsh3g0bkL9a42pU76csqhERXtmokTlvDbbRjGw8deiNGERH7678HgsodcgEmZM5
         dYvKubC+e+izpEAceYK6zttiu5lG/liNqIx798OJVJdJKx1NhUtgr4KI1RlCabZSBlx/
         z2CGAEq4Mn4W7OpMba74P/a+MUbsQnE+PYQapf5KbU5UJjXB5UepBwyOvY/yVR35JqCa
         TTVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmPzRXW1EV6ob8m7+5ifpjh6J5k+EDxMb98pJi853XOcRdPHtQe1JY9/uEZOgdMkAb9Zhjac+FaLayhA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywh8nCXCvZjGVygVDCcxLhvok9BCXqjVveHx9hpNh2icWEuNzcR
	t6VhsI2mgxQyWwviViTS2PchMpOVvAF57hOshQahCVOphUq8T6zVvy8DYJB8RUB0Rw==
X-Gm-Gg: ATEYQzymt8Zxn9yH6DDrJM41RzZUh53IVlL3lwyEJAB0SRUeXPu1RuAeol+Z0+hscYL
	4TdzGJ6rAwgKjJVHxuLpzhVayaYSxzu706vMqyja3I9dbA9shQDd7QS5MUFABLhE3OoHiJY/QxK
	/MaytqUc2P8jI5EYIaHlvZfl6LDhKaYbDSf6A9wF7Ck2qtRa+tDgkngs6x7cSiLSBfbkGZcmCWl
	nxZr7Cl37qKC/w0D61PXoik6lry5I79WjRMa12jeMqhDy50HAOzqwQSNHQnVM5ZKX99kN2NwPs5
	3VtOFuiVNC36AFXw/wcB11oYalptfed4qZi83XsoeyezuVHIWCG3HD9Sc2yK0z2YW8L47KLdeSd
	DrYaB1d3QqCULKOzunp+DNG0zXf/xla+xa/g4SCgMQRYmtc+AP4VQJ5QgNbLZQiYzC+CuVVOLix
	MOvaqtZFPkjULr36VXuDqAuYZuSl9cvmDb2JkeLGsvW23elXlbfRvmd+mZoXzBE88jj3QXgxUAV
	YIpEAk=
X-Received: by 2002:a05:622a:1ba4:b0:50b:31d6:f7c6 with SMTP id d75a77b69052e-50b31d6fef7mr186799181cf.7.1774239924167;
        Sun, 22 Mar 2026 21:25:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e80cb9sm77225111cf.25.2026.03.22.21.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 21:25:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [RFC PATCH v2 1/2] lsm: add backing_file LSM hooks
Date: Mon, 23 Mar 2026 00:24:18 -0400
Message-ID: <20260323042510.3331778-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323042510.3331778-4-paul@paul-moore.com>
References: <20260323042510.3331778-4-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21640; i=paul@paul-moore.com; h=from:subject; bh=2qG9Eocw1o42vkHbPECUzZlRiBr4pZG0viaLmkWV9qY=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpwMCmtA3Z59FUmK16Gu84+wv3S9aLsy8mhZ+sw EL3HF/WjO+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCacDApgAKCRDqIPLalzeJ cyLMD/sHHzrwjimmKFY1JTxJAgIQyx8lhakAOe/Sl9o/AISWj4d+VKtCli3M/saH1GOI/D/Enbz tuJwITWT/JksP12Cj6/4Hd9o0Qr0lSy78kNENHsScqTz4bHTzttb0SB4pUw+PM6p06wXL+t4x64 RxGUf42Zw5EwJqUSmPTAxYWCd4N20oS8S8WdThcBOJT7HQ+vbRAN8wPZAcOOXlOlD5ihWRDU5xy YawdZgc08IJvaPoRRvJ4ljIk/T4+JXWYjIWGBv97cs0cYtZDIfOHOkRqWFAmT22ypOWbiRXYs4B 4t81+0qA5i6WtBYPG2L8kVRAhLaqrKvgPPm8wuxb1yJeuEkHqAM9KtWJKNUmG9Xm35jM1SnaXvr /tPNKErFLu+THX+i36jSIEilc0xyvgtB5XwMp5vrnL2HJ+XwtBovzP7uijczfZJIOqVPUkpyPL5 GE+R7prHoPY1k48zacvbUIEUyWjcPttHiPccdHxu3dpOF5Jp7eCc+yWJdbwnNc3Tq433jukbKth lppAOlD89qB5ss0UvHH7mMkZpKtmDii0wGrimeYcDJMFLpGtv7eFFlDytiCekF8M/lZ9nbQ63VN 0Jf/GAEyZMJ7Tv7HdWMHfnhemPWM8U1QNPcw+JzmhSXu55d8o4baYLirdKj539QCPeFJg71xxx9 2cxVE4ww5L/W1fA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2941-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4FCE92EC6EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stacked filesystems such as overlayfs do not currently provide the
necessary mechanisms for LSMs to properly enforce access controls on the
mmap() and mprotect() operations.  In order to resolve this gap, a LSM
security blob is being added to the backing_file struct and the following
new LSM hooks are being created:

 security_backing_file_alloc()
 security_backing_file_free()
 security_mmap_backing_file()

The first two hooks are to manage the lifecycle of the LSM security blob
in the backing_file struct, while the third provides a new mmap() access
control point for the underlying backing file.  It is also expected that
LSMs will likely want to update their security_file_mprotect() callback
to address issues with their mprotect() controls, but that does not
require a change to the security_file_mprotect() LSM hook.

There are a two other small changes to support these new LSM hooks.  We
pass the user file associated with a backing file down to
alloc_empty_backing_file() so it can be included in the
security_backing_file_alloc() hook, and we constify the file struct field
in the LSM common_audit_data struct to better support LSMs that need to
pass a const file struct pointer into the common LSM audit code.

Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
and supplying a fixup.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/backing-file.c             |  18 ++++--
 fs/erofs/ishare.c             |  10 +++-
 fs/file_table.c               |  21 ++++++-
 fs/fuse/passthrough.c         |   2 +-
 fs/internal.h                 |   3 +-
 fs/overlayfs/dir.c            |   2 +-
 fs/overlayfs/file.c           |   2 +-
 include/linux/backing-file.h  |   4 +-
 include/linux/fs.h            |   1 +
 include/linux/lsm_audit.h     |   2 +-
 include/linux/lsm_hook_defs.h |   5 ++
 include/linux/lsm_hooks.h     |   1 +
 include/linux/security.h      |  22 ++++++++
 security/lsm.h                |   1 +
 security/lsm_init.c           |   9 +++
 security/security.c           | 100 ++++++++++++++++++++++++++++++++++
 16 files changed, 187 insertions(+), 16 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 45da8600d564..1f3bbfc75882 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -12,6 +12,7 @@
 #include <linux/backing-file.h>
 #include <linux/splice.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,14 +30,15 @@
  * returned file into a container structure that also stores the stacked
  * file's path, which can be retrieved using backing_file_user_path().
  */
-struct file *backing_file_open(const struct path *user_path, int flags,
+struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred)
 {
+	const struct path *user_path = &user_file->f_path;
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_file);
 	if (IS_ERR(f))
 		return f;
 
@@ -52,15 +54,16 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
 
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct file *user_file, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred)
 {
 	struct mnt_idmap *real_idmap = mnt_idmap(real_parentpath->mnt);
+	const struct path *user_path = &user_file->f_path;
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_file);
 	if (IS_ERR(f))
 		return f;
 
@@ -336,8 +339,13 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	scoped_with_creds(ctx->cred)
+	scoped_with_creds(ctx->cred) {
+		ret = security_mmap_backing_file(vma, file, user_file);
+		if (ret)
+			return ret;
+
 		ret = vfs_mmap(vma->vm_file, vma);
+	}
 
 	if (ctx->accessed)
 		ctx->accessed(user_file);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 829d50d5c717..ec3fc5ac1a55 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -4,6 +4,7 @@
  */
 #include <linux/xxhash.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 #include "internal.h"
 #include "xattr.h"
 
@@ -106,7 +107,8 @@ static int erofs_ishare_file_open(struct inode *inode, struct file *file)
 
 	if (file->f_flags & O_DIRECT)
 		return -EINVAL;
-	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
+	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred(),
+					    file);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 	ihold(sharedinode);
@@ -150,8 +152,14 @@ static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
 static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
+	int err;
 
 	vma_set_file(vma, realfile);
+
+	err = security_mmap_backing_file(vma, realfile, file);
+	if (err)
+		return err;
+
 	return generic_file_readonly_mmap(file, vma);
 }
 
diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e..0bdc26cae138 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -50,6 +50,7 @@ struct backing_file {
 		struct path user_path;
 		freeptr_t bf_freeptr;
 	};
+	void *security;
 };
 
 #define backing_file(f) container_of(f, struct backing_file, file)
@@ -66,6 +67,11 @@ void backing_file_set_user_path(struct file *f, const struct path *path)
 }
 EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
+void *backing_file_security(const struct file *f)
+{
+	return backing_file(f)->security;
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kmem_cache_free(bfilp_cachep, backing_file(f));
+		struct backing_file *ff = backing_file(f);
+
+		security_backing_file_free(&ff->security);
+		path_put(&ff->user_path);
+		kmem_cache_free(bfilp_cachep, ff);
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
  * This is only for kernel internal use, and the allocate file must not be
  * installed into file tables or such.
  */
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct file *user_file)
 {
 	struct backing_file *ff;
 	int error;
@@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 	}
 
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = security_backing_file_alloc(&ff->security, user_file);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
 	return &ff->file;
 }
 EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 72de97c03d0e..f2d08ac2459b 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -167,7 +167,7 @@ struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 		goto out;
 
 	/* Allocate backing file per fuse file to store fuse path */
-	backing_file = backing_file_open(&file->f_path, file->f_flags,
+	backing_file = backing_file_open(file, file->f_flags,
 					 &fb->file->f_path, fb->cred);
 	err = PTR_ERR(backing_file);
 	if (IS_ERR(backing_file)) {
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..77e90e4124e0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -106,7 +106,8 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct file *user_file);
 void backing_file_set_user_path(struct file *f, const struct path *path);
 
 static inline void file_put_write_access(struct file *file)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f..f2f20a611af3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1374,7 +1374,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 				return PTR_ERR(cred);
 
 			ovl_path_upper(dentry->d_parent, &realparentpath);
-			realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
+			realfile = backing_tmpfile_open(file, flags, &realparentpath,
 							mode, current_cred());
 			err = PTR_ERR_OR_ZERO(realfile);
 			pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 97bed2286030..27cc07738f33 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -48,7 +48,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 			if (!inode_owner_or_capable(real_idmap, realinode))
 				flags &= ~O_NOATIME;
 
-			realfile = backing_file_open(file_user_path(file),
+			realfile = backing_file_open(file,
 						     flags, realpath, current_cred());
 		}
 	}
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 1476a6ed1bfd..c939cd222730 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -18,10 +18,10 @@ struct backing_file_ctx {
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 };
 
-struct file *backing_file_open(const struct path *user_path, int flags,
+struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct file *user_file, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..8f5702cfb5e0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2474,6 +2474,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 const struct path *backing_file_user_path(const struct file *f);
+void *backing_file_security(const struct file *f);
 
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 382c56a97bba..584db296e43b 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -94,7 +94,7 @@ struct common_audit_data {
 #endif
 		char *kmod_name;
 		struct lsm_ioctlop_audit *op;
-		struct file *file;
+		const struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..2c4da40757ad 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -191,6 +191,9 @@ LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
 LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
+LSM_HOOK(int, 0, backing_file_alloc, void *backing_file_blobp,
+	 const struct file *user_file)
+LSM_HOOK(void, LSM_RET_VOID, backing_file_free, void *backing_file_blobp)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
 LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
@@ -198,6 +201,8 @@ LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
+LSM_HOOK(int, 0, mmap_backing_file, struct vm_area_struct *vma,
+	 struct file *backing_file, struct file *user_file)
 LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
 LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d48bf0ad26f4..b4f8cad53ddb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -104,6 +104,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	unsigned int lbs_cred;
 	unsigned int lbs_file;
+	unsigned int lbs_backing_file;
 	unsigned int lbs_ib;
 	unsigned int lbs_inode;
 	unsigned int lbs_sock;
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..1e4c68d5877f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -471,11 +471,17 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_release(struct file *file);
 void security_file_free(struct file *file);
+int security_backing_file_alloc(void **backing_file_blobp,
+				const struct file *user_file);
+void security_backing_file_free(void **backing_file_blobp);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file);
 int security_mmap_addr(unsigned long addr);
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot);
@@ -1140,6 +1146,15 @@ static inline void security_file_release(struct file *file)
 static inline void security_file_free(struct file *file)
 { }
 
+int security_backing_file_alloc(void **backing_file_blobp,
+				const struct file *user_file)
+{
+	return 0;
+}
+
+void security_backing_file_free(void **backing_file_blobp)
+{ }
+
 static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 				      unsigned long arg)
 {
@@ -1159,6 +1174,13 @@ static inline int security_mmap_file(struct file *file, unsigned long prot,
 	return 0;
 }
 
+static inline int security_mmap_backing_file(struct vm_area_struct *vma,
+					     struct file *backing_file,
+					     struct file *user_file)
+{
+	return 0;
+}
+
 static inline int security_mmap_addr(unsigned long addr)
 {
 	return cap_mmap_addr(addr);
diff --git a/security/lsm.h b/security/lsm.h
index db77cc83e158..32f808ad4335 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -29,6 +29,7 @@ extern struct lsm_blob_sizes blob_sizes;
 
 /* LSM blob caches */
 extern struct kmem_cache *lsm_file_cache;
+extern struct kmem_cache *lsm_backing_file_cache;
 extern struct kmem_cache *lsm_inode_cache;
 
 /* LSM blob allocators */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 573e2a7250c4..020eace65973 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -293,6 +293,8 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	blobs = lsm->blobs;
 	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_backing_file,
+			     &blob_sizes.lbs_backing_file);
 	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
 	/* inode blob gets an rcu_head in addition to LSM blobs. */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
@@ -441,6 +443,8 @@ int __init security_init(void)
 	if (lsm_debug) {
 		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
 		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
+		lsm_pr("blob(backing_file) size %d\n",
+		       blob_sizes.lbs_backing_file);
 		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
 		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
 		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
@@ -462,6 +466,11 @@ int __init security_init(void)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
 						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_backing_file)
+		lsm_backing_file_cache = kmem_cache_create(
+						   "lsm_backing_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
 	if (blob_sizes.lbs_inode)
 		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
 						    blob_sizes.lbs_inode, 0,
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..651a0d643c9f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -81,6 +81,7 @@ const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
+struct kmem_cache *lsm_backing_file_cache;
 struct kmem_cache *lsm_inode_cache;
 
 #define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
@@ -172,6 +173,28 @@ static int lsm_file_alloc(struct file *file)
 	return 0;
 }
 
+/**
+ * lsm_backing_file_alloc - allocate a composite backing file blob
+ * @backing_file_blobp: pointer to the backing file LSM blob pointer
+ *
+ * Allocate the backing file blob for all the modules.
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_backing_file_alloc(void **backing_file_blobp)
+{
+	if (!lsm_backing_file_cache) {
+		*backing_file_blobp = NULL;
+		return 0;
+	}
+
+	*backing_file_blobp = kmem_cache_zalloc(lsm_backing_file_cache,
+						GFP_KERNEL);
+	if (*backing_file_blobp == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * lsm_blob_alloc - allocate a composite blob
  * @dest: the destination for the blob
@@ -2417,6 +2440,57 @@ void security_file_free(struct file *file)
 	}
 }
 
+/**
+ * security_backing_file_alloc() - Allocate and setup a backing file blob
+ * @backing_file_blobp: pointer to the backing file LSM blob pointer
+ * @user_file: the associated user visible file
+ *
+ * Allocate a backing file LSM blob and perform any necessary initialization of
+ * the LSM blob.  There will be some operations where the LSM will not have
+ * access to @user_file after this point, so any important state associated
+ * with @user_file that is important to the LSM should be captured in the
+ * backing file's LSM blob.
+ *
+ * LSM's should avoid taking a reference to @user_file in this hook as it will
+ * result in problems later when the system attempts to drop/put the file
+ * references due to a circular dependency.
+ *
+ * Return: Return 0 if the hook is successful, negative values otherwise.
+ */
+int security_backing_file_alloc(void **backing_file_blobp,
+				const struct file *user_file)
+{
+	int rc;
+
+	rc = lsm_backing_file_alloc(backing_file_blobp);
+	if (rc)
+		return rc;
+	rc = call_int_hook(backing_file_alloc, *backing_file_blobp, user_file);
+	if (unlikely(rc))
+		security_backing_file_free(backing_file_blobp);
+
+	return rc;
+}
+
+/**
+ * security_backing_file_free() - Free a backing file blob
+ * @backing_file_blobp: pointer to the backing file LSM blob pointer
+ *
+ * Free any LSM state associate with a backing file's LSM blob, including the
+ * blob itself.
+ */
+void security_backing_file_free(void **backing_file_blobp)
+{
+	void *backing_file_blob = *backing_file_blobp;
+
+	call_void_hook(backing_file_free, backing_file_blob);
+
+	if (backing_file_blob) {
+		*backing_file_blobp = NULL;
+		kmem_cache_free(lsm_backing_file_cache, backing_file_blob);
+	}
+}
+
 /**
  * security_file_ioctl() - Check if an ioctl is allowed
  * @file: associated file
@@ -2505,6 +2579,32 @@ int security_mmap_file(struct file *file, unsigned long prot,
 			     flags);
 }
 
+/**
+ * security_mmap_backing_file - Check if mmap'ing a backing file is allowed
+ * @vma: the vm_area_struct for the mmap'd region
+ * @backing_file: the backing file being mmap'd
+ * @user_file: the user file being mmap'd
+ *
+ * Check permissions for a mmap operation on a stacked filesystem.  This hook
+ * is called after the security_mmap_file() and is responsible for authorizing
+ * the mmap on @backing_file.  It is important to note that the mmap operation
+ * on @user_file has already been authorized and the @vma->vm_file has been
+ * set to @backing_file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file)
+{
+	/* recommended by the stackable filesystem devs */
+	if (WARN_ON_ONCE(!(backing_file->f_mode & FMODE_BACKING)))
+		return -EIO;
+
+	return call_int_hook(mmap_backing_file, vma, backing_file, user_file);
+}
+EXPORT_SYMBOL_GPL(security_mmap_backing_file);
+
 /**
  * security_mmap_addr() - Check if mmap'ing an address is allowed
  * @addr: address
-- 
2.53.0


