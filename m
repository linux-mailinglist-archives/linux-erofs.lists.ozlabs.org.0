Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACF998A59
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 16:52:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPXmS5TSpz3bkg
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 01:52:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728571959;
	cv=none; b=Rx+pExWDQuH3aqCePnNpSFgMjVgO+W7F0vllhK0r/G2aquyOEcRHeHL7OH1aKwzC/1l5d72oz/a/fKNpXUCXRi4ndOvD5iUMoqOJshPgoX2ra2ZbJ6UWQtzJn/t5k03B34jQRb4Uui2ZUuFCPkr+AXYfrfkW50beymIzUZ8RzmGb4CXyWw9khS5GcG+Um8umUQxvLUUTgZozvg7fg/paK++xUe0Wg0pyFOmye/Apf1ajgrdjT++ECLCjs5tz7CX8FnMCDQvG0MekWXnlKklA2TkeQWjthidrcZtAsvCKZdP6UaDsQw8bsU5XcLTcriysKfG8+XoT1L4YyMJOdZ1Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728571959; c=relaxed/relaxed;
	bh=s/rzIBijz35TvrQXNNS/JV1cr2x4Od/FDIZTbeen1ZA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=flmzDmfrpFq6NjvbgqeGXqvDnOmno3iT2Y9cKKsjlVdhJv6UFl/T4XC3hNvRgUBXLkLPdsaLo3zCA8Cop9hv8mg+xCG+ONASBonsZ+zY0mtNumqP6/chH5HkyH3akdjFEjvUlbVzQnFthpaT89Zwaeyqwsx0aDn9bFv2ogRoc6I+BeOwzcsUFFDHKf7D1aif/MhPfdhZiR867mMUUINwIW7kJfifgIWHU7cmM/ct6Cupj3o+fmp0Gf9r4QeNiIKpLkYcFZlwk64cOx45zom6kr9gBYy68OSIYWaEI/eExb5gw2LTbNFH7vYRs5SAvRBQop2maj5y1lW58/jbnTF+CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6Y03y+z; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6Y03y+z; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6Y03y+z;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6Y03y+z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPXmQ4894z3bdV
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 01:52:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728571952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/rzIBijz35TvrQXNNS/JV1cr2x4Od/FDIZTbeen1ZA=;
	b=X6Y03y+zkYxOyFXnoqtfawhnhhsySBsaffiVIuEoozGmGochQ/juRA78C2pGZXQo+dLf0n
	OgGeokeAbnPm+Ze9VR7K898sSBRiDQfuM2B7l5wnbzkmjHx4rSr/HxS8bqVN4LInqNMBvd
	aeJUy6AHHRMZQ1dGVQ+VHgh/iY2gYEw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728571952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/rzIBijz35TvrQXNNS/JV1cr2x4Od/FDIZTbeen1ZA=;
	b=X6Y03y+zkYxOyFXnoqtfawhnhhsySBsaffiVIuEoozGmGochQ/juRA78C2pGZXQo+dLf0n
	OgGeokeAbnPm+Ze9VR7K898sSBRiDQfuM2B7l5wnbzkmjHx4rSr/HxS8bqVN4LInqNMBvd
	aeJUy6AHHRMZQ1dGVQ+VHgh/iY2gYEw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-cLA6nZKQNX2jBcl9sJatzw-1; Thu,
 10 Oct 2024 10:52:28 -0400
X-MC-Unique: cLA6nZKQNX2jBcl9sJatzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154261956046;
	Thu, 10 Oct 2024 14:52:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E14DE1956052;
	Thu, 10 Oct 2024 14:52:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com>
References: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com> <20240821024301.1058918-8-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com> <303977.1728559565@warthog.procyon.org.uk>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in object->file
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 15:52:20 +0100
Message-ID: <443969.1728571940@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> =E5=9C=A8 2024/10/10 19:26, David Howells =E5=86=99=E9=81=93:
> > Zizhi Wo <wozizhi@huawei.com> wrote:
> >=20
> >> +	spin_lock(&object->lock);
> >>   	if (object->file) {
> >>   		fput(object->file);
> >>   		object->file =3D NULL;
> >>   	}
> >> +	spin_unlock(&object->lock);
> > I would suggest stashing the file pointer in a local var and then doing=
 the
> > fput() outside of the locks.
> > David
> >=20
>=20
> If fput() is executed outside the lock, I am currently unsure how to
> guarantee that file in __cachefiles_write() does not trigger null
> pointer dereference...

I'm not sure why there's a problem here.  I was thinking along the lines of:

	struct file *tmp;
	spin_lock(&object->lock);
 	tmp =3D object->file)
	object->file =3D NULL;
	spin_unlock(&object->lock);
	if (tmp)
		fput(tmp);

Note that fput() may defer the actual work if the counter hits zero, so the
cleanup may not happen inside the lock; further, the cleanup done by __fput=
()
may sleep.

David

