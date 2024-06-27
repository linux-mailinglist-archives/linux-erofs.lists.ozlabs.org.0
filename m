Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE591A477
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 13:01:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MexA7hH0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8wcV1bHHz3cVb
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 21:01:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MexA7hH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8wcP4Z1mz3cCM
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 21:01:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 25C9261E21;
	Thu, 27 Jun 2024 11:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B160AC2BBFC;
	Thu, 27 Jun 2024 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719486099;
	bh=d9XGZ2kB3Lt/GXYoN+EjaPRKIEPhF2tefw/+D8t0oTk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MexA7hH0tR2F5X8b5EtDn8VpN0iKLpq2+zUi+ASp/gJhQ9pDdNkbgSnjSMxfjnbVI
	 +7JdDiFaosrI0SnEFNDJ6ceQaZDimYzg+BE6ZT4jj0vZgSUiuNRl099Zj5RIbgJ9cp
	 y75CKiI+N14qArASzJEwkeE+OWOpRdkM/+HFwRqZnNR7tPwtuPq8R0iQJnktkEloUb
	 iiCma2tk1xTbOPrzZibllYTBJmWxFY7rQzy009mFggg6ePVLMWbAe5Z0Ry6LwUV1Je
	 Tt7x+MgWKu5ax0tO9xBuBidj7OxuM6lI4gKmC1To0SgC2nJBbic/SxGHeUyizZTH/W
	 oqrqnMYU1yQgw==
Message-ID: <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object
 that is being dropped
From: Jeff Layton <jlayton@kernel.org>
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com
Date: Thu, 27 Jun 2024 07:01:37 -0400
In-Reply-To: <20240515125136.3714580-3-libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
	 <20240515125136.3714580-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>=20
> Because after an object is dropped, requests for that object are
> useless,
> flush them to avoid causing other problems.
>=20
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, flush it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
>=20
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> =C2=A0fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 73da4d4eaa9b..d24bff43499b 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
> cachefiles_object *object)
> =C2=A0
> =C2=A0void cachefiles_ondemand_clean_object(struct cachefiles_object
> *object)
> =C2=A0{
> +	unsigned long index;
> +	struct cachefiles_req *req;
> +	struct cachefiles_cache *cache;
> +
> =C2=A0	if (!object->ondemand)
> =C2=A0		return;
> =C2=A0
> =C2=A0	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
> =C2=A0			cachefiles_ondemand_init_close_req, NULL);
> +
> +	if (!object->ondemand->ondemand_id)
> +		return;
> +
> +	/* Flush all requests for the object that is being dropped.
> */

I wouldn't call this a "Flush". In the context of writeback, that
usually means that we're writing out pages now in order to do something
else. In this case, it looks like you're more canceling these requests
since you're marking them with an error and declaring them complete.

> +	cache =3D object->volume->cache;
> +	xa_lock(&cache->reqs);
> =C2=A0	cachefiles_ondemand_set_object_dropping(object);
> +	xa_for_each(&cache->reqs, index, req) {
> +		if (req->object =3D=3D object) {
> +			req->error =3D -EIO;
> +			complete(&req->done);
> +			__xa_erase(&cache->reqs, index);
> +		}
> +	}
> +	xa_unlock(&cache->reqs);
> =C2=A0}
> =C2=A0
> =C2=A0int cachefiles_ondemand_init_obj_info(struct cachefiles_object
> *object,

--=20
Jeff Layton <jlayton@kernel.org>
