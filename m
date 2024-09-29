Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BDD9896EB
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 20:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727636113;
	bh=bGJCXemhC9dAtd5JgEfyPJDtjJnxzGiGPrBvY6sj9XI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KL/zn/69dozq+GXuAvOyIZvOzSu7epyHvuITKTOYbWrBtR5sfJSOojEjmmI7hOFHR
	 jDHvHaWTZ1tpXA6DpPgifKuSEQRpgnZ3GTVK6Jcv2/d0gkyyWOywAvObNH6GiVc7dv
	 5zMDGUgMohmOY4QfvpTS5/4+D+HPLFn0x259vBWdGncXdgTJc+mbzHl3fl/zohOyFc
	 Ue1ja+5XdVAFm8PcqJvTgAnoXROnq5aPAPQ0T4rgiqUk3f0hfZOJFqoppftvrsES5a
	 TJGMjLqiY2Dvg2yNZSgxHatL0svU5NYhwbWgxYCStrW+iDpVFwHZobSgiF5KfeWlhE
	 VpmnW0fnwXg6Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XGtgP5wRxz2yDk
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 04:55:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727636110;
	cv=none; b=KDsPdEkrlDYDTivk2rY9lJ4S84M+eMgdSn3v8Kc5T1rzlVbChZUZLRR/puXqdFw3FKzYv3qbjr9H7Y4hSzR2s310Bxj8iNoO4YefuVRHQf5e2g8dqQ/puOSlsF8ZP0msAvXoKufd+wDB1TBT81ufUob6fQlZeQ82DEmNGtHBnkoQuuz7aBtgyynSqMM1OSIry/eyzkQ8s8bxHmO2qewY6IUZNhraSW560LEm0ITFrNf7+zTN02Wfs5FWhfkC0YOUT0eVaRZ4Ewh8lt72M4Ye8Ck1ZcKg8LdPGXeY1XL//6+fyDrtq77w7bHEuJmQ7+ARPTtGPJU2yf0hPtQubghQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727636110; c=relaxed/relaxed;
	bh=bGJCXemhC9dAtd5JgEfyPJDtjJnxzGiGPrBvY6sj9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkhzOA5gwWKYwcTK2Tn4tmQNRpO3vRqaVF9OcFIw894Ln9vilDF5+zAcQMqpCH3qnCnff0V7uWb8yu3oVX/dzxcVdcBCOos+KIf+Yu9XQiMqQqQ8pWAqjvuAbHlOSA2965pZE3jk1aG2DAKcmI185NY8TS7PHgR8GAmt6n5Ezn2+qCf9Y9cAl5fBWHn98/nfnEacYZgWVlOQaSBgHpCh0Nb3vOaPcf7auWPupmpcGJ7PkZR0aL/fwOBH14P7jhD7RPiSec4Z3qw81iLVsv3QKB7lKWDVZAiln811fD9uCax9faY++fJq0/jxlG4g4Mb3B2zvTCWnuiyot0swLqk0fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fr9kzvy9; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fr9kzvy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XGtgK53Lrz2xfR
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 04:55:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 935CD5C0709;
	Sun, 29 Sep 2024 18:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75091C4CEC7;
	Sun, 29 Sep 2024 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727636106;
	bh=jAulFupwHSoaUi/6sQaBbxwLwD4EQjNV6hWdaK3VMeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fr9kzvy9ZvXrAyv2UllxHifNu6IjR55if6yiVZdFsqEDWM8KeUI0i2OOazz1sJWgv
	 C7FEhIX+Kv8rKL4HR2qbLhRniIw90m53J/xKlPjSUHTvLxQzmeHsOQfGpPe7zNPydx
	 igiQKwOCunehcDRZ98DPEJvFwnQX6F+64GRE+zGIQbZUCsERuI8uzf7wQWQyYH/LgQ
	 IYBhLr3Up0Y5MYZrivJNKR+oquf3PaSy3JHujxIAywf0gC6wdBK0Vp5oFNxKDhmmaA
	 kX0Ijo0JsbL2WuHZ8K+T60FaR2mcFykzg5maIOHz5Do5MOUwczMMHqH9pe8OEFonhF
	 Rq5ezJWx1L3ug==
Date: Sun, 29 Sep 2024 21:55:01 +0300
To: Eduard Zingerman <eddyz87@gmail.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <20240929185501.GA218692@unreal>
References: <20240925103118.GE967758@unreal>
 <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
 <2808175.1727601153@warthog.procyon.org.uk>
 <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
From: Leon Romanovsky via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Leon Romanovsky <leon@kernel.org>
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 29, 2024 at 02:37:44AM -0700, Eduard Zingerman wrote:
> On Sun, 2024-09-29 at 10:12 +0100, David Howells wrote:
> > Can you try the attached?  I've also put it on my branch here:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/l=
og/?h=3Dnetfs-fixes
>=20
> Used your branch:
> fc22830c5a07 ("9p: Don't revert the I/O iterator after reading")
>=20
> dmesg is here:
> https://gist.github.com/eddyz87/4cd50c2cf01323641999dc386e2d41eb
>=20
> Still see null-ptr-deref.

I tried it too and I can confirm that the issue is still there.

Thanks

>=20
> [...]
>=20
