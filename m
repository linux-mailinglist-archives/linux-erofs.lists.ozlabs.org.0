Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE79984E9
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:24:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPS8P6TDnz3bkG
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:24:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728559475;
	cv=none; b=crYZDbEuEL/EjLax/3BrbQantWny9A4L5FKLaMVuTdOiXeYXGZsPDPypGncc/CcpBSExKKGF792Z5CMJY/InbsuQBsvJs1GASJrpv+xB32hjDKrxjRNYXDCEG495K1sejNjwTPO33JmxDJfV9m9hQI8D+OhGrYjGJGSTssHqCk8fryvZaJXdLmID1LTeFExPHgInyxcwtFhpfqsBpj3Mg6RzkUV2W4afVDYIaVv1sD1Cwl4E/cjLdbiQ2T6ZAj1EN5yy8Fm6vF1z7iKlDFYyv+7oMTtUeqstixTMpEJjv6zskg/gCZvcujvPTo4Oh5ioGqlcMlVvUf5zjH3NnBJsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728559475; c=relaxed/relaxed;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=R+2zgIL0jvjeRRWxh1++kFfXLP7IGaGiehbtchOhPMMq5XWOgShDQaCk1lNabmjsC2KVLJRW+I9n5ddWsc+ogfdDKOYHiYOhToyeHDLXgk3dUz86VmmBHd1SrA6S/JL9un9Uk081H2zadTgP5r4Ld9KSv9n+jdztC3U2xSg3OOSiZSp0lN346yhD/UtAiEBiM7KmMpXDD9j8mVXo9GwjZ+k4VxuXg0++lf3D6VjSZhPEyNd1A4aHoA/vEUmHvVV7qncFNuvm9BbgGExRYrPmbpimXScvBU2t5X7fUy+A73JJc08VkIY/3vsYQdLGhcYA2hvzOtaVNkY6Ku/I57wvvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ff9Rj2GC; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NyL2XsB7; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ff9Rj2GC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NyL2XsB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPS8L2HRkz2xjv
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:24:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	b=Ff9Rj2GCPvgvrK7jmSapLLIJdw62scD8EMjsBzOSsjZYW/cFfndcmkw9Z7EJhmQ3BT1zEs
	fAUhFQkvItQzOcxummc09yAwqW1mKx1+R28iSP+lHEVxGQIM0FFj/o5cWJap9+e6i1BzSG
	VxvRU/vx873mHNvJh75CK1UGrMedv/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91MakKXXdZ/X8v1/goDuWFlMTUMGbgqBgnskPiSeMP0=;
	b=NyL2XsB7eIcW+nFsUWbW+UsLrETCwQVsKB8Y5LCPhRCUzdbGkGc4B+NwzJEExFpwIEld2l
	X6kkO7fOzOFDauErX+GU0h2AKQICjcZQ740KGmAnqc7czXzfQVwnMvk38PM+hxzyqefDuv
	a9iGXAq2x3clsNGw/nDAZwAco6fVKDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-ppm18wj7PQSs_wzc0tN0EA-1; Thu,
 10 Oct 2024 07:24:24 -0400
X-MC-Unique: ppm18wj7PQSs_wzc0tN0EA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B128B195608C;
	Thu, 10 Oct 2024 11:24:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A21B819560AE;
	Thu, 10 Oct 2024 11:24:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-9-wozizhi@huawei.com>
References: <20240821024301.1058918-9-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 8/8] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303925.1728559457.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 12:24:17 +0100
Message-ID: <303926.1728559457@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> In fscache_create_volume(), there is a missing memory barrier between th=
e
> bit-clearing operation and the wake-up operation. This may cause a
> situation where, after a wake-up, the bit-clearing operation hasn't been
> detected yet, leading to an indefinite wait. The triggering process is a=
s
> follows:
> ...
> By combining the clear and wake operations into clear_and_wake_up_bit() =
to
> fix this issue.
> =

> Fixes: bfa22da3ed65 ("fscache: Provide and use cache methods to lookup/c=
reate/free a volume")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>

