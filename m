Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87856C17D
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 23:32:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lfmj14nRgz3c6N
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jul 2022 07:32:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anamf6ZR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anamf6ZR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anamf6ZR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anamf6ZR;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lfmht1zGwz2xXw
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Jul 2022 07:32:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657315959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cLD6V0BQa36edMLgHMFHkOTrNlZhNZjBOzy1qNyvvuU=;
	b=anamf6ZRW1lcFDePVS+1ccNveMqC5l+ZbzcBGxpF5yq6BR7NJivyv2hSSL8//S+/2tEPxy
	kJtX/zUySLhXvJJvvv1fceEY2frpKZwLQuKC0Mz8w6TfgiLFWxn7WsAHJEk3HOS7sgm78w
	Zpl+869aR+PiLWhLXTpIF+iJscHn5zU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657315959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cLD6V0BQa36edMLgHMFHkOTrNlZhNZjBOzy1qNyvvuU=;
	b=anamf6ZRW1lcFDePVS+1ccNveMqC5l+ZbzcBGxpF5yq6BR7NJivyv2hSSL8//S+/2tEPxy
	kJtX/zUySLhXvJJvvv1fceEY2frpKZwLQuKC0Mz8w6TfgiLFWxn7WsAHJEk3HOS7sgm78w
	Zpl+869aR+PiLWhLXTpIF+iJscHn5zU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-L1s-bVZRNh23PIdMI0BY5w-1; Fri, 08 Jul 2022 17:32:36 -0400
X-MC-Unique: L1s-bVZRNh23PIdMI0BY5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CECC1C05132;
	Fri,  8 Jul 2022 21:32:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1C540D282E;
	Fri,  8 Jul 2022 21:32:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] fscache: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3753786.1657315951.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jul 2022 22:32:31 +0100
Message-ID: <3753787.1657315951@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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
Cc: linux-cachefs@redhat.com, Max Kellermann <mk@cm4all.com>, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you pull these fscache/cachefiles fixes please?

 (1) Fix a check in fscache_wait_on_volume_collision() in which the
     polarity is reversed.  It should complain if a volume is still marked
     acquisition-pending after 20s, but instead complains if the mark has
     been cleared (ie. the condition has cleared).

     Also switch an open-coded test of the ACQUIRE_PENDING volume flag to
     use the helper function for consistency.

 (2) Not a fix per se, but neaten the code by using a helper to check for
     the DROPPED state.

 (3) Fix cachefiles's support for erofs to only flush requests associated
     with a released control file, not all requests.

 (4) Fix a race between one process invalidating an object in the cache an=
d
     another process trying to look it up.

Thanks,
David
---
The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9=
a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220708

for you to fetch changes up to 85e4ea1049c70fb99de5c6057e835d151fb647da:

  fscache: Fix invalidation/lookup race (2022-07-05 16:12:55 +0100)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
David Howells (1):
      fscache: Fix invalidation/lookup race

Jia Zhu (1):
      cachefiles: narrow the scope of flushed requests when releasing fd

Yue Hu (2):
      fscache: Fix if condition in fscache_wait_on_volume_collision()
      fscache: Introduce fscache_cookie_is_dropped()

 fs/cachefiles/ondemand.c |  3 ++-
 fs/fscache/cookie.c      | 26 ++++++++++++++++++++++----
 fs/fscache/volume.c      |  4 ++--
 include/linux/fscache.h  |  1 +
 4 files changed, 27 insertions(+), 7 deletions(-)

