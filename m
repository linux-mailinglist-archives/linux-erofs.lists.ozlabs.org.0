Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33198A381
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 14:52:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHLZR5FZfz2yyx
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 22:52:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727700748;
	cv=none; b=AYE/wuhA7u6yo1YCkCAdnc2WBOqxFJZ/reWDFzEuwMbLbSFP/zTNgimpPnocPI9lgbB7HPQ8eglSvJDbw4srkvChsHTYiNU3ZYVEescGsS6dgnyRk51RXV1vDv8gjay8wSmXJXR22DCbeFT7YMmJ6jHay18glIvhV3d8I7leHUMY7GycfYtJDXGjRjRfSB93q96KZt1l8mVKKr/gh40IqDf+e/VoarShxt63bsUG4EAWEGHYkQSvCFQbqzvuJybfPoNzUZ7RtxSWtPtYRb040383fXu1iCR3NFbc1PL+aM5IQtBf5zDzsU8G1lRq4eV7ELGm7yjkaCFKAU52j2OJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727700748; c=relaxed/relaxed;
	bh=iheTQuAAGoNV0Ml7YHfX3/4X0Beg93WMcxdOLm415Rw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fP9bJp/h/5mjkBmn1XisAmLhwh2hUoCTDRYhlAAdUubo2QSPrphC7LxHIPviyl/iBam9yVcQuvbc7cwWnmRXBqbnjFYd5pwlPYMydTVDLXlkP0LypnwKx1j4+hzG0pSRDi41wzocjS9hQNlxQL68M6obo8v5Va5MB9g9q0ptBObP/fv9DYEw7V/RasuHwyOEuCHK0D1lIUCwS5mQxLsqmwYqhCjZPgYROYn6zr+iTgbIv+Qechvvq8f2OSQ91c8jr9DoWlRvTtLzvqCaWWXNjLwza8DFV6AapK/UHcrbml5ilJvpXmdxqqFTJkN+bOnoofAS6Cv2C8KldIcAIeTiHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aVAiL5Lx; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aVAiL5Lx; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aVAiL5Lx;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aVAiL5Lx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHLZM4hT4z2xLR
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 22:52:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727700742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iheTQuAAGoNV0Ml7YHfX3/4X0Beg93WMcxdOLm415Rw=;
	b=aVAiL5LxFLKUu3me1kwOs/WO/wlz573H8Qpe3F3MtQLRRTmJQ8zt3rruB/5m9NxkMDijp8
	7iJUHwxFMJ838+5faSaRqfVdQorYAU/JYqMt1NRbEJFSqZcLiK/EMxeKJ7ZdUcJCrPoK+0
	7p4PXuhtYteHclcYirta1apJ4TSr8d0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727700742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iheTQuAAGoNV0Ml7YHfX3/4X0Beg93WMcxdOLm415Rw=;
	b=aVAiL5LxFLKUu3me1kwOs/WO/wlz573H8Qpe3F3MtQLRRTmJQ8zt3rruB/5m9NxkMDijp8
	7iJUHwxFMJ838+5faSaRqfVdQorYAU/JYqMt1NRbEJFSqZcLiK/EMxeKJ7ZdUcJCrPoK+0
	7p4PXuhtYteHclcYirta1apJ4TSr8d0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-yIEMnkANOcKlKeIOv07qjw-1; Mon,
 30 Sep 2024 08:52:17 -0400
X-MC-Unique: yIEMnkANOcKlKeIOv07qjw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E827197730E;
	Mon, 30 Sep 2024 12:52:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28F8519541A0;
	Mon, 30 Sep 2024 12:51:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2968940.1727700270@warthog.procyon.org.uk>
References: <2968940.1727700270@warthog.procyon.org.uk> <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2969659.1727700717.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 13:51:57 +0100
Message-ID: <2969660.1727700717@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells <dhowells@redhat.com> wrote:

> Okay, let's try something a little more drastic.  See if we can at least=
 get
> it booting to the point we can read the tracelog.  If you can apply the
> attached patch?

It's also on my branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

along with another one that clears the folio pointer after unlocking.

David

