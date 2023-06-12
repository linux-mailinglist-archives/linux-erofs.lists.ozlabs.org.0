Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CD72C409
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 14:27:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AGEIUN8w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQ5voQGf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfrY33lyjz30GP
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 22:27:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AGEIUN8w;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQ5voQGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Mon, 12 Jun 2023 22:27:12 AEST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QfrXw0jM6z307p
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jun 2023 22:27:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686572829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTMhvLLlxLduku60kqh9t4hhU2KGCMkQO9qTJKYmDvE=;
	b=AGEIUN8wDGJne4q/UIlyg5i8vu3TS/oSdD/eVJlB8bgSiB47foY+5ukqimtxJ3YCHNPsEi
	BU+UHFMGEmuq4U67joRFyEHv6H+MA2cpeWJ2r48UtolsQ+QKEWlUpXW3d2vpiTeNAqLUBd
	K0ZV0QpTWUiocDW6eG1mlLExqwsmGOU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686572830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTMhvLLlxLduku60kqh9t4hhU2KGCMkQO9qTJKYmDvE=;
	b=jQ5voQGfEnpdIpMPvs1rbLV59QuaE9AMM/Dy7TxRD926U0hGTuT2Q3OphtxrOxn7h1sYjC
	0+e3GYEKPkKYk4fIEayW/XaZ2M7xxJvYe07NkMiapn8oI65rZ1hd6q4LK746I1l85JrXzM
	c2jr0MHl9PX9sUKc3OUACUjNWhyW4bQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-AynBElupPJ6WiOJw2BAedg-1; Mon, 12 Jun 2023 08:25:57 -0400
X-MC-Unique: AynBElupPJ6WiOJw2BAedg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDEEC3C11C67;
	Mon, 12 Jun 2023 12:25:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 023222026833;
	Mon, 12 Jun 2023 12:25:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <202306121557.2d17019b-oliver.sang@intel.com>
References: <202306121557.2d17019b-oliver.sang@intel.com>
To: kernel test robot <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [splice] 2cb1e08985: stress-ng.sendfile.ops_per_sec 11.6% improvement
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <105868.1686572748.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 13:25:48 +0100
Message-ID: <105869.1686572748@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
Cc: jfs-discussion@lists.sourceforge.net, David Hildenbrand <david@redhat.com>, feng.tang@intel.com, dhowells@redhat.com, Linux Memory Management List <linux-mm@kvack.org>, linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org, linux-nilfs@vger.kernel.org, lkp@intel.com, Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com, ying.huang@intel.com, linux-ext4@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-ntfs-dev@lists.sourceforge.net, fengwei.yin@intel.com, ocfs2-devel@oss.oracle.com, oe-lkp@lists.linux.dev, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-karma-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

kernel test robot <oliver.sang@intel.com> wrote:

> kernel test robot noticed a 11.6% improvement of stress-ng.sendfile.ops_=
per_sec on:

If it's sending to a socket, this is entirely feasible.  The
splice_to_socket() function now sends multiple pages in one go to the netw=
ork
protocol's sendmsg() method to process instead of using sendpage to send o=
ne
page at a time.

David

