Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032E90E963
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 13:27:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Me8iKtJQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W41YY003Nz3dDh
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 21:27:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Me8iKtJQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W41YR43Vfz3cSH
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jun 2024 21:27:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 327AFCE1C96;
	Wed, 19 Jun 2024 11:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA94C2BBFC;
	Wed, 19 Jun 2024 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718796424;
	bh=0hOuCVZMzu4EPGwSP4jUUH6lE8b0tGGjf5OMxmllJmk=;
	h=Subject:To:Cc:From:Date:From;
	b=Me8iKtJQiDc2nu1kUCmqyR0+YGIFIu0fiMHPJ88h0v2BToXuLHuXIude7JuhRF0X2
	 bGFXV623Pvby25ovCOk4S116vpy3a9ZiFNqZUCZzg9r7ZUx1kzPWDrc7jDLm1U3gaN
	 Ei+X290iCIFBD56ShHx4BT6ffPuvmEbBIrMGw5eQ=
Subject: Patch "cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode" has been added to the 6.6-stable tree
To: chao@kernel.org,dhowells@redhat.com,gregkh@linuxfoundation.org,huyue2@coolpad.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org,marc.dionne@auristor.com,netfs@lists.linux.dev,xiang@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 13:27:01 +0200
Message-ID: <2024061901-dangle-idealism-cf51@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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
Cc: stable-commits@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     cachefiles-erofs-fix-null-deref-in-when-cachefiles-is-not-doing-ondemand-mode.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c3d6569a43322f371e7ba0ad386112723757ac8f Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 19 Jan 2024 20:49:34 +0000
Subject: cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode

From: David Howells <dhowells@redhat.com>

commit c3d6569a43322f371e7ba0ad386112723757ac8f upstream.

cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
cachefiles_create_tmpfile() does not check if object->ondemand is set
before dereferencing it, leading to an oops something like:

	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
	...
	Call Trace:
	 <TASK>
	 cachefiles_open_file+0xc9/0x187
	 cachefiles_lookup_cookie+0x122/0x2be
	 fscache_cookie_state_machine+0xbe/0x32b
	 fscache_cookie_worker+0x1f/0x2d
	 process_one_work+0x136/0x208
	 process_scheduled_works+0x3a/0x41
	 worker_thread+0x1a2/0x1f6
	 kthread+0xca/0xd2
	 ret_from_fork+0x21/0x33

Fix this by making cachefiles_ondemand_init_object() return immediately if
cachefiles->ondemand is NULL.

Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Gao Xiang <xiang@kernel.org>
cc: Chao Yu <chao@kernel.org>
cc: Yue Hu <huyue2@coolpad.com>
cc: Jeffle Xu <jefflexu@linux.alibaba.com>
cc: linux-erofs@lists.ozlabs.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/ondemand.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -611,6 +611,9 @@ int cachefiles_ondemand_init_object(stru
 	struct fscache_volume *volume = object->volume->vcookie;
 	size_t volume_key_size, cookie_key_size, data_len;
 
+	if (!object->ondemand)
+		return 0;
+
 	/*
 	 * CacheFiles will firstly check the cache file under the root cache
 	 * directory. If the coherency check failed, it will fallback to


Patches currently in stable-queue which might be from dhowells@redhat.com are

queue-6.6/cachefiles-resend-an-open-request-if-the-read-reques.patch
queue-6.6/cachefiles-add-restore-command-to-recover-inflight-o.patch
queue-6.6/cachefiles-introduce-object-ondemand-state.patch
queue-6.6/cachefiles-extract-ondemand-info-field-from-cachefil.patch
queue-6.6/cachefiles-erofs-fix-null-deref-in-when-cachefiles-is-not-doing-ondemand-mode.patch
