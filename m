Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id A15758C9E36
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 15:31:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XhnwnH2o;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjdZt04F9z3cmK
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 23:24:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XhnwnH2o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjdZp45npz3cWk
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 23:24:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA6A761CF1;
	Mon, 20 May 2024 13:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F33C2BD10;
	Mon, 20 May 2024 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716211470;
	bh=tmycHzHS16yUDsFnDDAGL9c2k/ykCsqRadkM55Fr7Rk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XhnwnH2o/kK01P+lYGJGEibHOO3m9DuugiCuE9yJ90uFaL2eM+Z/d2XN3lfTGzpFb
	 U4Wdfi2wQEEbGEARAa9r0h/ryL8Yte54qJzPeudrmaXyUi1BkFmVqPUbtUc1lrvbFV
	 XsHOTEM3WPnFIpxJ0fUeqvW/7p3x4ebrAR5QC1u+ujqVeEJsG5gMEPPpGKMb0g1zUK
	 rDW1NGM8VzK7VKTndup+Bftvki/RVcH2m9dQ5A1WdxCcqvAsFnANYp+gm6u8NyHqo7
	 3uj8bfGfzDkE9jUBcavi0KrEt6fVGzzxkJOkYHTb/1t1fSpWuKtwRysfthdhp0fM7v
	 U+/eUYApP/Nvg==
Message-ID: <e522702477bed6e73c1e365bd8bd77a4250955c2.camel@kernel.org>
Subject: Re: [PATCH v2 4/5] cachefiles: cyclic allocation of msg_id to avoid
 reuse
From: Jeff Layton <jlayton@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev, 
	dhowells@redhat.com
Date: Mon, 20 May 2024 09:24:27 -0400
In-Reply-To: <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
	 <20240515125136.3714580-5-libaokun@huaweicloud.com>
	 <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
	 <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
	 <4b1584787dd54bb95d700feae1ca498c40429551.camel@kernel.org>
	 <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
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

On Mon, 2024-05-20 at 20:42 +0800, Baokun Li wrote:
> On 2024/5/20 18:04, Jeff Layton wrote:
> > On Mon, 2024-05-20 at 12:06 +0800, Baokun Li wrote:
> > > Hi Jeff,
> > >=20
> > > Thank you very much for your review!
> > >=20
> > > On 2024/5/19 19:11, Jeff Layton wrote:
> > > > On Wed, 2024-05-15 at 20:51 +0800,
> > > > libaokun@huaweicloud.com=C2=A0wrote:
> > > > > From: Baokun Li <libaokun1@huawei.com>
> > > > >=20
> > > > > Reusing the msg_id after a maliciously completed reopen
> > > > > request may cause
> > > > > a read request to remain unprocessed and result in a hung, as
> > > > > shown below:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t3
> > > > > -------------------------------------------------
> > > > > cachefiles_ondemand_select_req
> > > > > =C2=A0=C2=A0 cachefiles_ondemand_object_is_close(A)
> > > > > =C2=A0=C2=A0 cachefiles_ondemand_set_object_reopening(A)
> > > > > =C2=A0=C2=A0 queue_work(fscache_object_wq, &info->work)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ondemand_object_worker
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachefiles_ondemand_init_obje=
ct(A)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachefiles_ondemand_sen=
d_req(OPEN)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // get msg_=
id 6
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_co=
mpletion(&req_A->done)
> > > > > cachefiles_ondemand_daemon_read
> > > > > =C2=A0=C2=A0 // read msg_id 6 req_A
> > > > > =C2=A0=C2=A0 cachefiles_ondemand_get_fd
> > > > > =C2=A0=C2=A0 copy_to_user
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Malicious c=
ompletion
> > > > > msg_id 6
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copen 6,-1
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachefiles_ond=
emand_copen
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 complete=
(&req_A->done)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // will =
not set the object
> > > > > to close
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // becau=
se ondemand_id &&
> > > > > fd is valid.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // ondemand_object_worker() is done
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // but the object is still reopenin=
g.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // new open re=
q_B
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > cachefiles_ondemand_init_object(B)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > cachefiles_ondemand_send_req(OPEN)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // reuse=
 msg_id 6
> > > > > process_open_req
> > > > > =C2=A0=C2=A0 copen 6,A.size
> > > > > =C2=A0=C2=A0 // The expected failed copen was executed successful=
ly
> > > > >=20
> > > > > Expect copen to fail, and when it does, it closes fd, which
> > > > > sets the
> > > > > object to close, and then close triggers reopen again.
> > > > > However, due to
> > > > > msg_id reuse resulting in a successful copen, the anonymous
> > > > > fd is not
> > > > > closed until the daemon exits. Therefore read requests
> > > > > waiting for reopen
> > > > > to complete may trigger hung task.
> > > > >=20
> > > > > To avoid this issue, allocate the msg_id cyclically to avoid
> > > > > reusing the
> > > > > msg_id for a very short duration of time.
> > > > >=20
> > > > > Fixes: c8383054506c ("cachefiles: notify the user daemon when
> > > > > looking up cookie")
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > > ---
> > > > > =C2=A0=C2=A0 fs/cachefiles/internal.h |=C2=A0 1 +
> > > > > =C2=A0=C2=A0 fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
> > > > > =C2=A0=C2=A0 2 files changed, 17 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/cachefiles/internal.h
> > > > > b/fs/cachefiles/internal.h
> > > > > index 8ecd296cc1c4..9200c00f3e98 100644
> > > > > --- a/fs/cachefiles/internal.h
> > > > > +++ b/fs/cachefiles/internal.h
> > > > > @@ -128,6 +128,7 @@ struct cachefiles_cache {
> > > > > =C2=A0=C2=A0=C2=A0	unsigned long			req_id_next;
> > > > > =C2=A0=C2=A0=C2=A0	struct xarray			ondemand_ids;	/*
> > > > > xarray for ondemand_id allocation */
> > > > > =C2=A0=C2=A0=C2=A0	u32				ondemand_id_next;
> > > > > +	u32				msg_id_next;
> > > > > =C2=A0=C2=A0 };
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0 static inline bool cachefiles_in_ondemand_mode(struc=
t
> > > > > cachefiles_cache *cache)
> > > > > diff --git a/fs/cachefiles/ondemand.c
> > > > > b/fs/cachefiles/ondemand.c
> > > > > index f6440b3e7368..b10952f77472 100644
> > > > > --- a/fs/cachefiles/ondemand.c
> > > > > +++ b/fs/cachefiles/ondemand.c
> > > > > @@ -433,20 +433,32 @@ static int
> > > > > cachefiles_ondemand_send_req(struct cachefiles_object
> > > > > *object,
> > > > > =C2=A0=C2=A0=C2=A0		smp_mb();
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0		if (opcode =3D=3D CACHEFILES_OP_CLOSE &&
> > > > > -
> > > > > 			!cachefiles_ondemand_object_is_open(object)) {
> > > > > +		=C2=A0=C2=A0=C2=A0
> > > > > !cachefiles_ondemand_object_is_open(object)) {
> > > > > =C2=A0=C2=A0=C2=A0			WARN_ON_ONCE(object->ondemand-
> > > > > >ondemand_id =3D=3D 0);
> > > > > =C2=A0=C2=A0=C2=A0			xas_unlock(&xas);
> > > > > =C2=A0=C2=A0=C2=A0			ret =3D -EIO;
> > > > > =C2=A0=C2=A0=C2=A0			goto out;
> > > > > =C2=A0=C2=A0=C2=A0		}
> > > > > =C2=A0=C2=A0=20
> > > > > -		xas.xa_index =3D 0;
> > > > > +		/*
> > > > > +		 * Cyclically find a free xas to avoid
> > > > > msg_id reuse that would
> > > > > +		 * cause the daemon to successfully copen a
> > > > > stale msg_id.
> > > > > +		 */
> > > > > +		xas.xa_index =3D cache->msg_id_next;
> > > > > =C2=A0=C2=A0=C2=A0		xas_find_marked(&xas, UINT_MAX,
> > > > > XA_FREE_MARK);
> > > > > +		if (xas.xa_node =3D=3D XAS_RESTART) {
> > > > > +			xas.xa_index =3D 0;
> > > > > +			xas_find_marked(&xas, cache-
> > > > > >msg_id_next - 1, XA_FREE_MARK);
> > > > > +		}
> > > > > =C2=A0=C2=A0=C2=A0		if (xas.xa_node =3D=3D XAS_RESTART)
> > > > > =C2=A0=C2=A0=C2=A0			xas_set_err(&xas, -EBUSY);
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0		xas_store(&xas, req);
> > > > > -		xas_clear_mark(&xas, XA_FREE_MARK);
> > > > > -		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> > > > > +		if (xas_valid(&xas)) {
> > > > > +			cache->msg_id_next =3D xas.xa_index +
> > > > > 1;
> > > > If you have a long-standing stuck request, could this counter
> > > > wrap
> > > > around and you still end up with reuse?
> > > Yes, msg_id_next is declared to be of type u32 in the hope that
> > > when
> > > xa_index =3D=3D UINT_MAX, a wrap around occurs so that msg_id_next
> > > goes to zero. Limiting xa_index to no more than UINT_MAX is to
> > > avoid
> > > the xarry being too deep.
> > >=20
> > > If msg_id_next is equal to the id of a long-standing stuck
> > > request
> > > after the wrap-around, it is true that the reuse in the above
> > > problem
> > > may also occur.
> > >=20
> > > But I feel that a long stuck request is problematic in itself, it
> > > means
> > > that after we have sent 4294967295 requests, the first one has
> > > not
> > > been processed yet, and even if we send a million requests per
> > > second, this one hasn't been completed for more than an hour.
> > >=20
> > > We have a keep-alive process that pulls the daemon back up as
> > > soon as it exits, and there is a timeout mechanism for requests
> > > in
> > > the daemon to prevent the kernel from waiting for long periods
> > > of time. In other words, we should avoid the situation where
> > > a request is stuck for a long period of time.
> > >=20
> > > If you think UINT_MAX is not enough, perhaps we could raise
> > > the maximum value of msg_id_next to ULONG_MAX?
> > > > Maybe this should be using
> > > > ida_alloc/free instead, which would prevent that too?
> > > >=20
> > > The id reuse here is that the kernel has finished the open
> > > request
> > > req_A and freed its id_A and used it again when sending the open
> > > request req_B, but the daemon is still working on req_A, so the
> > > copen id_A succeeds but operates on req_B.
> > >=20
> > > The id that is being used by the kernel will not be allocated
> > > here
> > > so it seems that ida _alloc/free does not prevent reuse either,
> > > could you elaborate a bit more how this works?
> > >=20
> > ida_alloc and free absolutely prevent reuse while the id is in use.
> > That's sort of the point of those functions. Basically it uses a
> > set of
> > bitmaps in an xarray to track which IDs are in use, so ida_alloc
> > only
> > hands out values which are not in use. See the comments over
> > ida_alloc_range() in lib/idr.c.
> >=20
> Thank you for the explanation!
>=20
> The logic now provides the same guarantees as ida_alloc/free.
> The "reused" id, indeed, is no longer in use in the kernel, but it is
> still
> in use in the userland, so a multi-threaded daemon could be handling
> two different requests for the same msg_id at the same time.
>=20
> Previously, the logic for allocating msg_ids was to start at 0 and
> look
> for a free xas.index, so it was possible for an id to be allocated to
> a
> new request just as the id was being freed.
>=20
> With the change to cyclic allocation, the kernel will not use the
> same
> id again until INT_MAX requests have been sent, and during the time
> it takes to send requests, the daemon has enough time to process
> requests whose ids are still in use by the daemon, but have already
> been freed in the kernel.
>=20
>=20

If you're checking for collisions somewhere else, then this should be
fine:

Acked-by: Jeff Layton <jlayton@kernel.org>
