Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41A971A1E
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 14:56:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2Rfc6kbQz2yQl
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 22:56:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725886580;
	cv=none; b=OcqC+6Em/ny5CbBB7HqJI0GYBo470eAQAZ3eBDW0ijNmgr2/as0f1734LELEARp/go2xZ9B4hAkYLn+upd5o9cqAi3t1V0TseO8tsv2/d+j2zefSa+0acEb2pxer37VoJe1zE3vo32qXdKtBx2+boE7OQRM1vKO2nDgTjRBpSqMcWhs4Hjiy6pubkPgFUo9cfHIgoACYkhyl0wjgXfiVffKyG5oXlHr5yw6rRTnJkcT88TPBesKott2jsNAkySBnJ6iacVCJyq2y/vDDGS92kcZfm4CxveexTA9sCEX5yIQbyIHdVVM+tmOnkH6+1DmKUVeC5TmaA2kgllPZAB23Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725886580; c=relaxed/relaxed;
	bh=zzJBBMf+zohuvcLUo41tDA+vsEhpgbS/Jc7eQESKcS8=;
	h=DKIM-Signature:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Message-Id:In-Reply-To:References:Subject:Content-Type; b=esJNwuou0aOuOHH/t3+ZjlBFqlJ4ogWMFN0TTeen6ZJVv8fcjlzABZpoo3ifbm8OOAyYXCCALQ0suPCdBkMN+bsIkoDh51EnvfnnuRklbY8cXK06QxNmY0WYfLDtno8Wkg5jgTWhXeECtNXoEikt6W3ZnyL6PsIRfQ0ujjorbJpE7PxPB82/9iooGypENg4ZM8DI84RIw0c1T+xefy4k+7alJKCL+xo+OOlUD7JUIXUUoLd2idGv5oP+pYl5+c/DCmveXll1MXP42UzmhARAlU6S+IWqVQgIBuStih7Fc5NyLjU/bi589eiFIpWRcJc+PrdaCh3eSm12VrZEH4ff1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=G8bOdjKa; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=S13T8gmN; dkim-atps=neutral; spf=pass (client-ip=103.168.172.149; helo=fout6-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=G8bOdjKa;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=S13T8gmN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=103.168.172.149; helo=fout6-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 419 seconds by postgrey-1.37 at boromir; Mon, 09 Sep 2024 22:56:17 AEST
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2RfT6l6Pz2yL0
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 22:56:17 +1000 (AEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 740261380226;
	Mon,  9 Sep 2024 08:49:13 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 08:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725886153;
	 x=1725972553; bh=zzJBBMf+zohuvcLUo41tDA+vsEhpgbS/Jc7eQESKcS8=; b=
	G8bOdjKaDXZAbmEbd/pAHr26PgnbXfZUFCYgX8hWhXC/AqkmRMyCVSd5PckEyjFu
	lthK9zTHSFiiHsWoQwE/6e7ifKZlWHQO4b/Dt2eZ+amSbhTNQCUveX32J1Dq4UG9
	SWZGSpOvClahJ6O8Mu0+A4+6la6JTl2xsn5ql2IfTtqRYoFyc9jRTP1Y3GuHvdRp
	gLZ9R2TrnHkq8b7K3qvkiXJMUFAQgeXIv0fBg/A5HO1JZ09F6QQjCvur6GgQpdZY
	JH1uUXPiKPwLSp3juaDLromTpVPSAXx1qNf/sZUoFHV6w8mnb8AJ8mOYW3NXSDoN
	7t3OyOZSnGnaonGj0pJimw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725886153; x=
	1725972553; bh=zzJBBMf+zohuvcLUo41tDA+vsEhpgbS/Jc7eQESKcS8=; b=S
	13T8gmNnalWX57csimCaxNTwJCX7WXFsO8GPubmApkuJeTdgAju//lwEFEpEii9j
	uPZXciQgipjtUK7vctuOTkil+V59ESUjI5rHW/Doato4Rs+4Ikq5WIyw0j5FmaKr
	OTb0McJZowuqBWbBxEWQ/jIkeJsZTDyc2QuL8x18J2UuOrw7VD5oZA0zoEZOoOmn
	4YNHks++TrS14mJmqiEsOVbZEPA5X2jpri/oWlF0P0JAua8b+hhgg0p+oNXznUk+
	MmjB+zvWpaOeQ31yEOfGZcuhoMcXNiNvKni9aU6Uk14VzN2dJKHQSgz+3NjuqpfJ
	ELimHOH/ULP9s7jR0CxXA==
X-ME-Sender: <xms:yO7eZhDi19Ulq55cErvPi18PxbfCGkpGTJnHvSZFsIZzwptvCHEw9A>
    <xme:yO7eZvi8u5DoyZ2-HplfActyo5uC2cYcqEKKvdHQ4DCYnXddpSiACqEpvZQJiB4vr
    LcUZIbn-LthcP4p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevohhlihhnucghrghlthgv
    rhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgfehtdettedtkeeftdfgtdejtedvhffgtefftdetkedtjeeggeeuheejkeekheffnecu
    ffhomhgrihhnpehhohhnghhgfhhuiiiirdguvghvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhsh
    hirghnghhkrghosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yO7eZsmdtodOE6kzj_F3EAmwH8yEX-J4qufiOYz6BYsfafvyEnwxkA>
    <xmx:yO7eZrwws-LtBshFfEz-MYAdd94C5VAlICvzXDrcu3fLf4mP8aUkjA>
    <xmx:yO7eZmRsqLX7J3kXCdxk0Ti1fM83WnN9HxNKxGAVktYYa2Px1CAGoQ>
    <xmx:yO7eZuaaLs8GgDPtln14sx2FipDH_cEVcOxzEUq1QEOOlHCeo1yHcw>
    <xmx:ye7eZhciR4momiIk6uIjCiohvZlgXBb1Hx6lOY498zd5ijNtAWtenaYu>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7EAF529C006F; Mon,  9 Sep 2024 08:49:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 08:48:52 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
In-Reply-To: <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On Sun, Sep 8, 2024, at 11:19 PM, Gao Xiang wrote:
> Fast symlink can be used if the on-disk symlink data is stored
> in the same block as the on-disk inode, so we don=E2=80=99t need to tr=
igger
> another I/O for symlink data.  However, correctly fs correction could =
be
> reported _incorrectly_ if inode xattrs are too large.
>
> In fact, these should be valid images although they cannot be handled =
as
> fast symlinks.
>
> Many thanks to Colin for reporting this!

Yes, though feel free to also add
Reported-by: https://honggfuzz.dev/=20
or so...not totally sure how to credit it "kernel style" bit honggfuzz v=
ery much helped me find this bug (indirectly).



>
> Reported-by: Colin Walters <walters@verbum.org>
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - sent out a wrong version (`m_pofs +=3D vi->xattr_isize` was missed).
>
>  fs/erofs/inode.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..f2cab9e4f3bc 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -178,12 +178,14 @@ static int erofs_fill_symlink(struct inode=20
> *inode, void *kaddr,
>  			      unsigned int m_pofs)
>  {
>  	struct erofs_inode *vi =3D EROFS_I(inode);
> -	unsigned int bsz =3D i_blocksize(inode);
> +	loff_t off;
>  	char *lnk;
>=20
> -	/* if it cannot be handled with fast symlink scheme */
> -	if (vi->datalayout !=3D EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >=3D bsz || inode->i_size < 0) {
> +	m_pofs +=3D vi->xattr_isize;
> +	/* check if it cannot be handled with fast symlink scheme */
> +	if (vi->datalayout !=3D EROFS_INODE_FLAT_INLINE || inode->i_size < 0=
 ||
> +	    check_add_overflow(m_pofs, inode->i_size, &off) ||
> +	    off > i_blocksize(inode)) {
>  		inode->i_op =3D &erofs_symlink_iops;
>  		return 0;
>  	}

This change LGTM.

> @@ -192,16 +194,6 @@ static int erofs_fill_symlink(struct inode *inode=
,=20
> void *kaddr,
>  	if (!lnk)
>  		return -ENOMEM;
>=20
> -	m_pofs +=3D vi->xattr_isize;
> -	/* inline symlink data shouldn't cross block boundary */
> -	if (m_pofs + inode->i_size > bsz) {

It can cross a boundary but it still can't be *bigger* right? IOW do we =
still need to check here for inode->i_size > bsz or is that handled by s=
omething else generic?
