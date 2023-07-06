Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E046E749B2B
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 13:53:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SePrBr0s;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QxZfc5gCFz3brm
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 21:53:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SePrBr0s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QxZfX2tnyz3bnt
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jul 2023 21:53:08 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 58F5B6190E;
	Thu,  6 Jul 2023 11:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D464FC433CC;
	Thu,  6 Jul 2023 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688644383;
	bh=DImhtAAJpjJiKkZEkG2LSJB03B+4xwGNCaN9PNMpV6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SePrBr0s42/gJR7yJhjbFLUq2cYm1S/WFm5gDRN3iw/t+s6Y9KUEIOX3gjLsh45DW
	 mctT9y7hpRwO/Sb94gYLEE/ptkSj2D2mdqcC8gbHm6fc5xeJ7hoT/cdeTdjfEJsouA
	 Jm2fW2OVVe8nhpmchKFKXvd8tTBCvpuQSPrrFA9ptK/wfJpV4evB4M/gu3asi++HzK
	 B3kqojwc7Y64iWO5rE957Pp7esj9S5ZSb7HVhyMtJ8nM7WzwVjYYqZY1bVpW6eg5tX
	 1j6P6GUb20Pp/QgeRNT27d12slmu6rI+cTGtsTQkP7smWFxYa9dzSTAuAkB1UaaFmL
	 iFHPIrNm4SFRw==
Message-ID: <b1cc6c70a42bf41d023eea9f11ff0aaea10a56c3.camel@kernel.org>
Subject: Re: [PATCH v2 39/92] erofs: convert to ctime accessor functions
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Date: Thu, 06 Jul 2023 07:53:01 -0400
In-Reply-To: <20230706110007.dc4tpyt5e6wxi5pt@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
	 <20230705190309.579783-1-jlayton@kernel.org>
	 <20230705190309.579783-37-jlayton@kernel.org>
	 <20230706110007.dc4tpyt5e6wxi5pt@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 2023-07-06 at 13:00 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:04, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Acked-by: Gao Xiang <xiang@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Just one nit below:
>=20
> > @@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *b=
uf,
> >  		vi->chunkbits =3D sb->s_blocksize_bits +
> >  			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
> >  	}
> > -	inode->i_mtime.tv_sec =3D inode->i_ctime.tv_sec;
> > -	inode->i_atime.tv_sec =3D inode->i_ctime.tv_sec;
> > -	inode->i_mtime.tv_nsec =3D inode->i_ctime.tv_nsec;
> > -	inode->i_atime.tv_nsec =3D inode->i_ctime.tv_nsec;
> > +	inode->i_mtime.tv_sec =3D inode_get_ctime(inode).tv_sec;
> > +	inode->i_atime.tv_sec =3D inode_get_ctime(inode).tv_sec;
> > +	inode->i_mtime.tv_nsec =3D inode_get_ctime(inode).tv_nsec;
> > +	inode->i_atime.tv_nsec =3D inode_get_ctime(inode).tv_nsec;
>=20
> Isn't this just longer way to write:
>=20
> 	inode->i_atime =3D inode->i_mtime =3D inode_get_ctime(inode);
>=20
> ?
>=20
> 								Honza

Yes. Chalk that one up to coccinelle. Fixed in my tree.
--=20
Jeff Layton <jlayton@kernel.org>
