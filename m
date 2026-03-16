Return-Path: <linux-erofs+bounces-2770-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDOZJON3uGn5dgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2770-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE392A1089
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZT1T6LRDz2xln;
	Tue, 17 Mar 2026 08:36:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773696989;
	cv=none; b=eSNwEMgPbIUX20G2aRkvtBzKynmzOJMkQwzF4vtSAqxeHeB8tcXsSeoYyGwJSwy/eSq3lhztJU0DqGpcjeMfILe9K+qmcDxQ12feY0gnOXRK9sKqhUyQTjJvdIavexe9WvtW+3ukGgLmhOzpeajq8hTb1uHnSE07aBxM9Q8VbCO6ZxkBiA5sM1q9C1xF2mp7wgIX3+eMJhCS9cxDLCbZRvZCtlPU+AeEX0U5yyTzcegBHbxhocvgfq8VfWKlqZnALxx1kTGtY7R4NsFJ+lM42ZEYvmb42oi40h6ZU9v5EzYfSdfHHc/MhT0RpSxa/1rSG5+KOcwFnlINUV3E6rn3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773696989; c=relaxed/relaxed;
	bh=hTsLH1MNdb+4eQsSukde0PobQXZ5LXJ2xbUvSGeH18E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrMgOA7efYaoEQEr6NVIJqgUUF/T4AVaj4WuuwsM4CtIIede8yUKNPJwLREX4yI6A400DIY2evkg0enBMbh/mnoE+/rkU2X4uInEoyNa3EUOxPXLr1aN8AcW4BQQWmgqVSCcv225Gijt1Tjj0PsAilXNxwE/S5HNE1v518GcHaYWsYaqaG/FlML/lz9DqfF9zwVQy+SJ010qb85uvjEFfoYFEwB2/l1wR7V7JzjYBh9cMNYzcmzHXIuCXpotp326nO6hbFS2ecVHFtzTLq1hhqpnYi+0+9OuAQ2ruzlX6122lWbe8qQKtB2Q2raRTpR8fGBhYDgPyqdfiIa/jXc48Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BYFAgX69; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BYFAgX69;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZT1T1P48z2xQB
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:36:29 +1100 (AEDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-8cd90401034so545135685a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696986; x=1774301786; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTsLH1MNdb+4eQsSukde0PobQXZ5LXJ2xbUvSGeH18E=;
        b=BYFAgX69NYtjp1v4gPSoo3zHiaBqNt71kV6pelXC8+uP8Fu/2AOuBHWAqDSQNlWPEH
         EvoK3paFULzc5VIlXIJMm3iApSJhLvahglgGObh5KiYbwrP0Vd9J+QKEs4RrZu+QkzxZ
         evMR6QPSyFOIIGbLWZOK6BY04YYAuFR9Yq8EVJLimsogNmgUfsCA6o+ZK9Y1UvhGn/G5
         oWTEFl8wnJUFGz+D9aFjDyEwkODqEZRE47Ohaik6XFjY+dOcBupZILkzMly0Alcvokk4
         PKr+TsAKM+N6hYODg8o5JWoKwnKl2XoQWdcLTlxUUPyq/X2Te8kolT5HkHTE5FnM6p4B
         QXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696986; x=1774301786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTsLH1MNdb+4eQsSukde0PobQXZ5LXJ2xbUvSGeH18E=;
        b=nekOfcqAh4radvSf8W0DlgkVLInE/18YXUW6FqTs3CFOAwYhzc+uGp15yGSA4ANZYp
         o5ROHCwkJSjMvedXeqPkkieRai16IBTov7hlDsOX513eTkfdvZ+E0IA3tHMQYMCWIY7P
         1TsSP/le7UeNEHO4BfomidiEWVjteCJfixmp4fWulQ38HXWS1f9J6zTe2F5Vb163wKst
         v5G1XK73SxCqXxw10/If68cz/mupvypIQayjE7HU6ra53SVWd8DtxmSWOlXocCXnYFhU
         28t2BqJ2JkTkHWGDrtBxcuqgsMgL+WmnsJBkHK037Hlo9l3lxOy4q91/7sVOrGltJJLt
         030g==
X-Forwarded-Encrypted: i=1; AJvYcCXTW1l9YpVk7RdLnTushzY+TpF9kh10e0MafnOoTg6lrM5mSVTGrVD/YnjoWkzZ/ZWpJj7LvVOC9+FirQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHy/TabblJFy3JzSEx5XxMpCIAOG/YXF5k1mXhOHkTVenD0Rqu
	ClCvEo8QfhijxvEByxNPhd/eXBxzt4YjdjGrnlnu45r+6wCFaELR+mgXAdqE72v5vw==
X-Gm-Gg: ATEYQzwjW6s63vH4KV9E/4t5uKB8/fcHSf1pMGT0qvs9CX/o3GS4dxXwrfF66ca62fZ
	RR4Gsfz/umFH1g7ZpW1cyP4FxfO2lpW1bjtfwWpKL4NJ5szKR87kMzhtQO6JPPkguzwgkjfDbQw
	R7cg6LNQ9hcEAq8yn8oqlNt0Q2HxS8Lq8kRoYLoYrL+UgZPnn1LSSfJn11WO9XuYso4znAz2lRT
	JZ9FgdxMVmelFV6Ypb4XurzinkFUwVog2pQu3uDQPT/4BIEX7kBQuf+QpfSGIsVy+CWW8s7Emhw
	C4TkEJ+HmCIIaOAG3iPndHIm90K2LsMyAQbI/UVhAzcs4MjNqU9XjUw6/gaF+6dFupynosOSUxU
	QSrfCNZ8HcF3w9lDelluX7VZ+TCPm9MBfQTLaGe5RpVxcKn71rt8KxPNPszloBM24cGXzvc9net
	8zxFWEDm242xLZaCPm1I+OyKOl6QlB92raodJAUsLc8KI0JVcj0XQyFx5RzXykSUzObGE/
X-Received: by 2002:a05:620a:4452:b0:8cd:91b4:8225 with SMTP id af79cd13be357-8cdb5b21c1bmr1920572085a.40.1773696986434;
        Mon, 16 Mar 2026 14:36:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2151db2sm1241918285a.44.2026.03.16.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:25 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 3/3] selinux: fix overlayfs mmap() and mprotect() access checks
Date: Mon, 16 Mar 2026 17:35:58 -0400
Message-ID: <20260316213606.374109-8-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
References: <20260316213606.374109-5-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7434; i=paul@paul-moore.com; h=from:subject; bh=WtafcBhkNjwN/vp7IcaPNnu/9+5NgIh+9C6Xc3B9scE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpuHfNl2n7U5d3uCSuiCJ0pcaLH2KBlzhET15UZ /VXba2LXguJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCabh3zQAKCRDqIPLalzeJ c/r4D/43yZPGbaF4C/icZgs1GQN6W84UpGasnfPDaWHYaEJPvywAnFA/BsR9Bx56Ag5xdtx9/Gj 1auuQ3dKUwZS19EMzIG/0XLs2KN4lHJsN/1ZMGDfeurZXRkkGO+gpirLiOcUJT3cW6WXL3FEOMB M+vpqKVfywXWnm9AjtHKbBUneccnmqTtLn+PhnWleJBieZBFsQu1fVLduG7Xpdywl0ZJmrfFYYc Wc0Mlj3LfLhJ4COyiolcKYaT2rJxP2m3KOo4VmFAJc5OLOklkG1e6xbLyrbrkMajrDfMCVW8lDa /84AlvlfHOhUtTruAM11fynwQa508e7MVti0Z+MeOSd+9o5TgQYrV3/8rvHmEfcbxgHXoL71dTX wuC24MPUfUZoZ+X6gujHb8MOC4uSa+e3bEEQBW/zHzQlVAK+xl8ptCQeqkG5cu1KPyor30J6oLK eVTvnl1jRU0GWLC2Nx9Whi8uY1g4zkh3i/9FQ/cxuzQ/w3wRb8J5odeMtC4COYPFfu1qYog8TLF KdPKH+qNJGu/uer+B/hQoG/MkU6jCtrRIafiP7floG+bc5w64CGButwO4TLstTemt0Fb8vjaQ8f K3Gr/Hc3rN3SXFQm+1hjRWdfKjExHcH/lyCYwAWuyg+P2/0xXbx9bGmasehfhFpqAFY+6H3qC6z EFYJs2NeuiSWSUQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-2770-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EFE392A1089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing SELinux security model for overlayfs is to allow access if
the current task is able to access the top level file (the "user" file)
and the mounter's credentials are sufficient to access the lower
level file (the "backing" file).  Unfortunately, the current code does
not properly enforce these access controls for both mmap() and mprotect()
operations on overlayfs filesystems.

This patch makes use of the newly created security_mmap_backing_file()
LSM hook to provide the missing backing file enforcement for mmap()
operations on overlayfs files, and leverages the new
backing_file_user_path_file() VFS API to provide an equivalent to the
missing user file in mprotect().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 108 ++++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 18 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d8224ea113d1..013e1e35a1ff 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 #include <linux/memfd.h>
+#include <linux/backing-file.h>
 
 #include "initcalls.h"
 #include "avc.h"
@@ -1754,7 +1755,7 @@ static int bpf_fd_pass(const struct file *file, u32 sid);
    access to the file is not checked, e.g. for cases
    where only the descriptor is affected like seek. */
 static int file_has_perm(const struct cred *cred,
-			 struct file *file,
+			 const struct file *file,
 			 u32 av)
 {
 	struct file_security_struct *fsec = selinux_file(file);
@@ -3942,9 +3943,9 @@ static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
 
 static int default_noexec __ro_after_init;
 
-static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
+static int file_map_prot_check(const struct cred *cred, const struct file *file,
+			       unsigned long prot, bool shared)
 {
-	const struct cred *cred = current_cred();
 	u32 sid = cred_sid(cred);
 	int rc = 0;
 
@@ -3993,36 +3994,86 @@ static int selinux_mmap_addr(unsigned long addr)
 	return rc;
 }
 
-static int selinux_mmap_file(struct file *file,
-			     unsigned long reqprot __always_unused,
-			     unsigned long prot, unsigned long flags)
+static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
+				    unsigned long prot, bool shared)
 {
-	struct common_audit_data ad;
-	int rc;
-
 	if (file) {
+		int rc;
+		struct common_audit_data ad;
+
 		ad.type = LSM_AUDIT_DATA_FILE;
 		ad.u.file = file;
-		rc = inode_has_perm(current_cred(), file_inode(file),
-				    FILE__MAP, &ad);
+		rc = inode_has_perm(cred, file_inode(file), FILE__MAP, &ad);
 		if (rc)
 			return rc;
 	}
 
-	return file_map_prot_check(file, prot,
-				   (flags & MAP_TYPE) == MAP_SHARED);
+	return file_map_prot_check(cred, file, prot, shared);
+}
+
+static int selinux_mmap_file(struct file *file,
+			     unsigned long reqprot __always_unused,
+			     unsigned long prot, unsigned long flags)
+{
+	return selinux_mmap_file_common(current_cred(), file, prot,
+					(flags & MAP_TYPE) == MAP_SHARED);
+}
+
+/**
+ * selinux_mmap_backing_file - Check mmap permissions on a backing file
+ * @vma: memory region
+ * @backing_file: stacked filesystem backing file
+ * @user_file: user visible file
+ *
+ * This is called after selinux_mmap_file() on stacked filesystems, and it
+ * is this function's responsibility to verify access to @backing_file and
+ * setup the SELinux state for possible later use in the mprotect() code path.
+ *
+ * By the time this function is called, mmap() access to @user_file has already
+ * been authorized and @vma->vm_file has been set to point to @backing_file.
+ *
+ * Return zero on success, negative values otherwise.
+ */
+static int selinux_mmap_backing_file(struct vm_area_struct *vma,
+				     struct file *backing_file,
+				     struct file *user_file __always_unused)
+{
+	unsigned long prot = 0;
+
+	/* translate vma->vm_flags perms into PROT perms */
+	if (vma->vm_flags & VM_READ)
+		prot |= PROT_READ;
+	if (vma->vm_flags & VM_WRITE)
+		prot |= PROT_WRITE;
+	if (vma->vm_flags & VM_EXEC)
+		prot |= PROT_EXEC;
+
+	return selinux_mmap_file_common(backing_file->f_cred, backing_file,
+					prot, vma->vm_flags & VM_SHARED);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long reqprot __always_unused,
 				 unsigned long prot)
 {
+	int rc;
 	const struct cred *cred = current_cred();
 	u32 sid = cred_sid(cred);
+	const struct file *file = vma->vm_file;
+	const struct file *backing_file = NULL;
+
+	/* check if adjustments are needed for stacked filesystems */
+	if (file && (file->f_mode & FMODE_BACKING)) {
+		backing_file = vma->vm_file;
+		file = backing_file_user_path_file(backing_file);
+
+		/* sanity check the special O_PATH user file */
+		if (WARN_ON(!(file->f_mode & FMODE_OPENED)))
+			return -EPERM;
+	}
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
-		int rc = 0;
 		/*
 		 * We don't use the vma_is_initial_heap() helper as it has
 		 * a history of problems and is currently broken on systems
@@ -4036,11 +4087,15 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
-		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
+			if (rc)
+				return rc;
+		} else if (!file && (vma_is_initial_stack(vma) ||
 			    vma_is_stack_for_current(vma))) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
-		} else if (vma->vm_file && vma->anon_vma) {
+			if (rc)
+				return rc;
+		} else if (file && vma->anon_vma) {
 			/*
 			 * We are making executable a file mapping that has
 			 * had some COW done. Since pages might have been
@@ -4048,13 +4103,29 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 			 * modified content.  This typically should only
 			 * occur for text relocations.
 			 */
-			rc = file_has_perm(cred, vma->vm_file, FILE__EXECMOD);
+			rc = file_has_perm(cred, file, FILE__EXECMOD);
+			if (rc)
+				return rc;
+			if (backing_file) {
+				rc = file_has_perm(backing_file->f_cred,
+						   backing_file, FILE__EXECMOD);
+				if (rc)
+					return rc;
+			}
 		}
+	}
+
+	rc = file_map_prot_check(cred, file, prot, vma->vm_flags & VM_SHARED);
+	if (rc)
+		return rc;
+	if (backing_file) {
+		rc = file_map_prot_check(backing_file->f_cred, backing_file,
+					 prot, vma->vm_flags & VM_SHARED);
 		if (rc)
 			return rc;
 	}
 
-	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
+	return 0;
 }
 
 static int selinux_file_lock(struct file *file, unsigned int cmd)
@@ -7501,6 +7572,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
+	LSM_HOOK_INIT(mmap_backing_file, selinux_mmap_backing_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
 	LSM_HOOK_INIT(file_lock, selinux_file_lock),
-- 
2.53.0


