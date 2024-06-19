Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E190EF1E
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 15:35:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0n8cAb8m;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W44Pw21fgz3cY1
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 23:35:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0n8cAb8m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W44Pq5qzZz2xb2
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jun 2024 23:35:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2D52861CDF;
	Wed, 19 Jun 2024 13:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E8C2BBFC;
	Wed, 19 Jun 2024 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718804136;
	bh=/hcqL9FwP19LMfUqAroGcHsNZE8fztLdGrWqB+2MuU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0n8cAb8mRtew+pMlgyLn4K+ZiWNMGVadm7RL3MzBDVL+uFTwMNMCljLxi3U1pshcL
	 kcHHeFp1hDIpOzbmlaw+eSRFVUT4gD1RkNiCA+MzRcJsl/r8PUSJ+BXoz0HPfTwvvi
	 38QwA3i6nfKzg9Jg+u6w7TiTHGTGGHlsacr6TUEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.1 207/217] cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode
Date: Wed, 19 Jun 2024 14:57:30 +0200
Message-ID: <20240619125604.674196659@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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
Cc: linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, David Howells <dhowells@redhat.com>, Yue Hu <huyue2@coolpad.com>, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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


