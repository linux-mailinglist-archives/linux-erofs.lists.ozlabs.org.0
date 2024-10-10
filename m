Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C60EC9984F4
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:27:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPSCW5j13z3bkG
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:27:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728559637;
	cv=none; b=QnywnGsb7jSHR/Ei7yZ/mqJP3ic2OAItrzt3AkuW9YFfORQyGS0lXv8jHAiXmrYCajWrHhsWkfc/+SBVm8brIBNv2atHH+eA378yImeYeY8KeVelUNJRXWO7ziFESdC14lX4w/RgyvVIz7g9+28YJ8H9SukHfcBVbqPtT0xishRM5C+FmAnKLTjJpZ3bTAlFm4kHyXRSYddPROVeBx475R/roFiqAdMYtAcSK9xLP/LKeHq+H9ly/Nel4hg8KIMBF/JYUzxZYtytAUl3ZuMh17Kn6UdhxM9SH+wcM1v9H5c2iM1Pm4rI+0qzhhof+PCXRhkGK0ZbTTVp5sg44wjRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728559637; c=relaxed/relaxed;
	bh=Eq/0sQ9QSl7+JfnyZYKaS6BiFxibDB0xi/+v/5+P29c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=LVYSXzMROY7s3hwk2jxassnCV5A0bA+IaJpXWZtXz4pqEFkl6Po2KhsTxzkGjg23R0F9qoYAtDeVK2HzkokteDBrN6r0Ttjar42LHhB1kpiP1CSEE6XHGrIE3g7h+N4qv9Ncuj8QI+X7Ko9rDclIyQLp60DeRE6wyIqNSdsCrOf3P/4k+eAdh7r4W8NHRS7f8xX+0eWhrppZTYdSuUlXNjfJDA3ncVd4YqZZmh8uXY4quwvXE663b8egRaUW4XfGSPLzUYv6VplNrfRp5ax+PMFHJFLR6UrWO+ADV9PxxpZ/QxofIuO3e2PWP8upPcl2al5PlTMEeBkboG7TZdxXJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NEr9wvKE; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EDqp4cNr; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NEr9wvKE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EDqp4cNr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPSCS37hvz2xjv
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:27:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq/0sQ9QSl7+JfnyZYKaS6BiFxibDB0xi/+v/5+P29c=;
	b=NEr9wvKEr3DkF/nl3gi+KF3d0SKFvgNu0XhzKyk5Es5yCKjSWGZnmKKni2zOwohpnjK9Cp
	uzPZ+l+OjXbRUPLL4trfrDC2knunq81KW0Sh5YN+2aHDztLSK0d/pTgLHX4U7XvwDcWhpA
	w/Kb6Na5rgsVMAb2Qh8grJCn8RWZ700=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq/0sQ9QSl7+JfnyZYKaS6BiFxibDB0xi/+v/5+P29c=;
	b=EDqp4cNr4kf49va/OBtYAlLmngxuXthShl4jXx9QK490C0F4n+Q3fMGWKoNrIBFQvxEe7h
	R8w1I6nxm0broK06soUAjIZegKb4MgO//QkiTaVyOanZt6kHj4hlVgCZF/gtVIJClzHcQQ
	7YWRUikl05wZvC8wXQ68hW+/+ZY8kGY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206--6Q7z21RMtWhXfgKRbCahQ-1; Thu,
 10 Oct 2024 07:27:05 -0400
X-MC-Unique: -6Q7z21RMtWhXfgKRbCahQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1527E19560BF;
	Thu, 10 Oct 2024 11:27:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D27D19560AA;
	Thu, 10 Oct 2024 11:26:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-4-wozizhi@huawei.com>
References: <20240821024301.1058918-4-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 3/8] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <304003.1728559613.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 12:26:54 +0100
Message-ID: <304004.1728559614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the erofs on-demand loading scenario, read and write operations are
> usually delivered through "off" and "len" contained in read req in user
> mode. Naturally, pwrite is used to specify a specific offset to complete
> write operations.
> =

> However, if the write(not pwrite) syscall is called multiple times in th=
e
> read-ahead scenario, we need to manually update ki_pos after each write
> operation to update file->f_pos.
> =

> This step is currently missing from the cachefiles_ondemand_fd_write_ite=
r
> function, added to address this issue.
> =

> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up=
 cookie")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>

