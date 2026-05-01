Return-Path: <linux-erofs+bounces-3371-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMa+J+Oq9GmBDQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3371-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 01 May 2026 15:30:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8FA4ACBB6
	for <lists+linux-erofs@lfdr.de>; Fri, 01 May 2026 15:30:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6X3165BMz2xnZ;
	Fri, 01 May 2026 23:30:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777642205;
	cv=none; b=dCX0aEEOXLyp/2f4OdvVNyUlJekwn2mKLuL7iXyQ5k9nZNPBSM4KpBTue9bEhhAARPhseF3H5IEJBzrbrD7FzBuGDrSwreyPN/YCcZKBsN1wySd/Pfefb1udMb3CfU3torp4N02IB3Gp6SdOQzOOuWRNFHBN5rlpCyB9Deq/RH5pfZXxXf0I5Vm4aRGrUiHaBgqgpt8yHglsS/vcVvOGadlEz8zRn3tSQRk8MvOCuV/cKjR4nCGSvNkaVdcitwNvIJnKGmANvqArFvk6ls7STc9u+wmPOLnuI2bPecimC6Zf7axKOfrttPflbmN4KMQo3YkAqzsNpzpBGsi1t3McgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777642205; c=relaxed/relaxed;
	bh=mDVy7Azey5O5hWWVi+FB7TD4gdYy17O7zVYrZSYIVQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k66h8kfRW4MQor6iyTqjFghA7OQkuPyZ4ttTR1RTdyCmCJANIvpkX3KAheyGRjel9C9ICU4PH9iwrIxjAyHLrX1vEFrZEtGU4SHw4DNAaTJ5eBSSgB5wXJBBP+0w6sJNeQP6pmcesBx11wwXKGjZwCKBp3V5Sf58839xpYsghk23NF0S0Y0oQwgCXvzyHW6EWnxxE5Y4cz3BU3qzXd7RgfNc49QoRBKUwi9WuQGAGBvORfRZJAxExo/yttVh9waffpZkLbtUQUKUG2kE2IkOLtsQyQ6wdiWk71LwZGHDDed093x2noZDgZO0tx480Kup9dQDFPlUCsa9843almF3Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CLbhuLfX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CLbhuLfX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6X2z5Bfvz2xC3
	for <linux-erofs@lists.ozlabs.org>; Fri, 01 May 2026 23:30:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A5FA74081E;
	Fri,  1 May 2026 13:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2B4C2BCB4;
	Fri,  1 May 2026 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777642200;
	bh=ASEsIyCct01k+hukQ4D0eMR904jmoKlLNFnUmR1FdDI=;
	h=Subject:To:Cc:From:Date:From;
	b=CLbhuLfXtnizDDfjCC0MU9bfCvYSQEiPvuPyz4RdgdzIsepxARGwz/lCpVbmv+ss0
	 OUfxj1xe330daLcQ0dXTeurh6266XUnSJUWMs9JWLIE8N93mcn6EDd0Pvs/B95WMVf
	 7unTGt0aeIsU3/bRiEzoC580qXorJgI9EoF6cyfA=
Subject: Patch "fs: prepare for adding LSM blob to backing_file" has been added to the 7.0-stable tree
To: amir73il@gmail.com,gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org,paul@paul-moore.com,serge@hallyn.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 15:29:48 +0200
Message-ID: <2026050148-hacking-static-797f@gregkh>
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
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 7D8FA4ACBB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,lists.ozlabs.org,paul-moore.com,hallyn.com];
	TAGGED_FROM(0.00)[bounces-3371-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:paul@paul-moore.com,m:serge@hallyn.com,m:stable-commits@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:email]


This is a note to let you know that I've just added the patch titled

    fs: prepare for adding LSM blob to backing_file

to the 7.0-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fs-prepare-for-adding-lsm-blob-to-backing_file.patch
and it can be found in the queue-7.0 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 880bd496ec72a6dcb00cb70c430ef752ba242ae7 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Mar 2026 10:27:51 +0200
Subject: fs: prepare for adding LSM blob to backing_file

From: Amir Goldstein <amir73il@gmail.com>

commit 880bd496ec72a6dcb00cb70c430ef752ba242ae7 upstream.

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
[PM: use the term "LSM blob", fix comment style to match file]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file_table.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -66,6 +66,12 @@ void backing_file_set_user_path(struct f
 }
 EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
+static inline void backing_file_free(struct backing_file *ff)
+{
+	path_put(&ff->user_path);
+	kmem_cache_free(bfilp_cachep, ff);
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -73,8 +79,7 @@ static inline void file_free(struct file
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kmem_cache_free(bfilp_cachep, backing_file(f));
+		backing_file_free(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -283,6 +288,12 @@ struct file *alloc_empty_file_noaccount(
 	return f;
 }
 
+static int init_backing_file(struct backing_file *ff)
+{
+	memset(&ff->user_path, 0, sizeof(ff->user_path));
+	return 0;
+}
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -305,7 +316,14 @@ struct file *alloc_empty_backing_file(in
 		return ERR_PTR(error);
 	}
 
+	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = init_backing_file(ff);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
+
 	return &ff->file;
 }
 EXPORT_SYMBOL_GPL(alloc_empty_backing_file);


Patches currently in stable-queue which might be from amir73il@gmail.com are

queue-7.0/fs-prepare-for-adding-lsm-blob-to-backing_file.patch
queue-7.0/selinux-fix-overlayfs-mmap-and-mprotect-access-checks.patch
queue-7.0/lsm-add-backing_file-lsm-hooks.patch

