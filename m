Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94247680E6F
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 14:05:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P57h209qVz3cFN
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 00:05:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsTmxfO+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsTmxfO+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsTmxfO+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsTmxfO+;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P57gs0zd8z3bW0
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 00:04:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675083890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uBCujYj2Veetu7QK57xU7G/CWr3+t3ZM1ReUnbevAXw=;
	b=FsTmxfO+S+Onkd3o+T4mL6JgjMWmPoeI3D95j4re85b5tr8mhIRynnYmki6KMvIvZSLLm3
	ULL1eYWCbhBo09hpLSO+imgPdUioWu0s93gvR/014Fpyo6v318+/EQ07j2WxjNX5WD96i+
	CVKcoNNK+RRr1v/SNaj6w1zwz/3B0Zw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675083890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uBCujYj2Veetu7QK57xU7G/CWr3+t3ZM1ReUnbevAXw=;
	b=FsTmxfO+S+Onkd3o+T4mL6JgjMWmPoeI3D95j4re85b5tr8mhIRynnYmki6KMvIvZSLLm3
	ULL1eYWCbhBo09hpLSO+imgPdUioWu0s93gvR/014Fpyo6v318+/EQ07j2WxjNX5WD96i+
	CVKcoNNK+RRr1v/SNaj6w1zwz/3B0Zw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-TGlHHuprOdK2blxvl6wn1A-1; Mon, 30 Jan 2023 08:04:46 -0500
X-MC-Unique: TGlHHuprOdK2blxvl6wn1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46E1285A588;
	Mon, 30 Jan 2023 13:04:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D3742166B29;
	Mon, 30 Jan 2023 13:04:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] fscache: Fix incorrect mixing of wake/wait and missing barriers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3425803.1675083883.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2023 13:04:43 +0000
Message-ID: <3425804.1675083883@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
Cc: Hou Tao <houtao@huaweicloud.com>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, houtao1@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you pull these fixes from Hou Tao please?  There are two problems
fixed in fscache volume handling:

 (1) wake_up_bit() is incorrectly paired with wait_var_event().  The latte=
r
     selects the waitqueue to use differently.

 (2) Missing barriers ordering between state bit and task state.

Thanks,
David

To quote Hou Tao:

    The patchset includes two fixes for fscache volume operations: patch 1
    fixes the hang problem during volume acquisition when the volume
    acquisition process waits for the freeing of relinquished volume, patc=
h
    2 adds the missing memory barrier in fscache_create_volume_work() and =
it
    is spotted through code review when checking whether or not these is
    missing smp_mb() before invoking wake_up_bit().

    Change Log:
    v3:
     * Use clear_and_wake_up_bit() helper (Suggested by Jingbo Xu)
     * Tidy up commit message and add Reviewed-by tag

    v2: https://listman.redhat.com/archives/linux-cachefs/2022-December/00=
7402.html
     * rebased on v6.1-rc1
     * Patch 1: use wait_on_bit() instead (Suggested by David)
     * Patch 2: add the missing smp_mb() in fscache_create_volume_work()

    v1: https://listman.redhat.com/archives/linux-cachefs/2022-December/00=
7384.html

Link: https://lore.kernel.org/r/20230113115211.2895845-1-houtao@huaweiclou=
d.com
---
The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c470=
0:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20230130

for you to fetch changes up to 3288666c72568fe1cc7f5c5ae33dfd3ab18004c8:

  fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work() (20=
23-01-30 12:51:54 +0000)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
Hou Tao (2):
      fscache: Use wait_on_bit() to wait for the freeing of relinquished v=
olume
      fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work()

 fs/fscache/volume.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

