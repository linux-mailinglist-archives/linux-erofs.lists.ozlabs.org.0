Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB2627CA1
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 12:44:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N9nXz6Bssz3cGm
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 22:44:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0e91hfR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0e91hfR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0e91hfR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0e91hfR;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N9nXt4y1lz3bb2
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Nov 2022 22:44:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668426281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhSzxc71gtsWdv7tBdLboQapjVVOXhkp285VQ60rL4=;
	b=H0e91hfR0q3LFfeFBnu5xRq2Z2XXYdxp36NIBtfUN9C5KWoPRuYEROnGvdzuoj/+OyxGjW
	yN8bGzuiICs6cxoZjyzUlwK9bDeJ1CywUeCNt4PFYjEyr98QugMAyZOyao05OoLVJ32elo
	Za41f0riYqxeY5tfDaRngWNH0YQiZec=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668426281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhSzxc71gtsWdv7tBdLboQapjVVOXhkp285VQ60rL4=;
	b=H0e91hfR0q3LFfeFBnu5xRq2Z2XXYdxp36NIBtfUN9C5KWoPRuYEROnGvdzuoj/+OyxGjW
	yN8bGzuiICs6cxoZjyzUlwK9bDeJ1CywUeCNt4PFYjEyr98QugMAyZOyao05OoLVJ32elo
	Za41f0riYqxeY5tfDaRngWNH0YQiZec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-Otw1wR4uPsei68QnsffE2A-1; Mon, 14 Nov 2022 06:44:37 -0500
X-MC-Unique: Otw1wR4uPsei68QnsffE2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA228101A528;
	Mon, 14 Nov 2022 11:44:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E805140C6EC2;
	Mon, 14 Nov 2022 11:44:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
References: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix missing xas_retry() in fscache mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <575541.1668426273.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Nov 2022 11:44:33 +0000
Message-ID: <575542.1668426273@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> The xarray iteration only holds RCU

I would say "the RCU read lock".

Also, I think you've copied the code to which my dodgy-maths fix applies:

	https://lore.kernel.org/linux-fsdevel/166757988611.950645.762695906984689=
3164.stgit@warthog.procyon.org.uk/

David

