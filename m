Return-Path: <linux-erofs+bounces-3388-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDO7MW7y/mlyzwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3388-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 09 May 2026 10:38:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 447ED4FEC0F
	for <lists+linux-erofs@lfdr.de>; Sat, 09 May 2026 10:38:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCKBK05BKz2xqv;
	Sat, 09 May 2026 18:38:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=157.180.15.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778315880;
	cv=none; b=bndro1muMqaM7ANB+HG+XwoqFmA8T23+prpnjSmYgDJaJTHhb4k35gxKyUu18HhpQzELAe4VQeq38gTlPXBb7M5yL+zWuuxGd33GGHttJtAHxkPw9cH/Dqp1lD/LmmJf2utk3yM5mQFRat+8pOfWIoUCL23gx4YewKu58Hi3O42OuWK+0AZYREgNlt6P6ItCOk3kt0Ua7wzn4YdJpRy9AxgQBVLr6QFYx4nPOwBsfVezbX5KrKtbi9dvET9hBYj0tGSXgTk4HyTj2bStTdPqOUj1dJhceaHD2Hv+xXJM/ObaxvWpHmMWm9Y/tCxgZpaSmhkvsQ5cmsaLx2v7IFUbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778315880; c=relaxed/relaxed;
	bh=a4ELv9zhowiGaFHNAAdNBmNOWi49gtc3sqkeOS/LWw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hv3Y0w20s4zWkQvZCNLcF3nZPeXyyDlwVSh1riX3xZI+arlw44LuCxEKPoQeFu8EQjQWcL80sSl9bYdVLV75SHJsswo4YES9NZFE5BcGeAZaIu+z4dvFEFRJiTuuOlSddoD0BreiA6d/u5dEHwiREbsigydDBkMBKP6wMOLKBrHernwdMr5gU6QWitdRuLNrY0m8NqprGBfZ6+j1GIepEQS8arP6UbnEfK4GS8HAwPWUjo4JdETU7s4HB4FF4kK0gizFy6YNQMa0kX63CgI11HdgCxq7M+KcJS0NYmvqCQj0HU5+Lk5LXrL5ZNh5fhF73S6OT/dzJJzEjuVTGxSFXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=bqpzx3Me; dkim-atps=neutral; spf=pass (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org) smtp.mailfrom=envs.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=bqpzx3Me;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=envs.net (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org)
Received: from mail.envs.net (mail.envs.net [157.180.15.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCKBG07zkz2xf8
	for <linux-erofs@lists.ozlabs.org>; Sat, 09 May 2026 18:37:56 +1000 (AEST)
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id E36C81C00D9;
	Sat,  9 May 2026 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1778315870; bh=a4ELv9zhowiGaFHNAAdNBmNOWi49gtc3sqkeOS/LWw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqpzx3MegjC+kOtLkIk0Tn7zkXvFkpX8gDREZPJIsZX6PCGesD1kkiENCLshxXR4m
	 dORzYFrL6BiQh2jCK7LlWc7Q9Lua8it6kOz4n+2iLnbejjRDmrznMzv5AryTvpPxy8
	 J4DNgZjiUXLMi5sFv6j1schKL6T/CzrLeef1aTz4nOBGvmtUexnDXmYS5IhQfKDl3u
	 ggDtbAQN+V1ZtEeQTuPzJltvadnlLwwh3AWwWpXx4zrjmCxx5KKRIajQkGfG2w8Sbf
	 AxwnrkPAX/9NEXxohbbLM8DGytV/1AQNveZfS1IiWdjmL1ZW5rbulH9LcdRl0gbcZw
	 bTIz9WvGd/l7JbixSbpRu8rIyuIUi1FujjLiPvezqvvetIUnTh5Wu3J/At274PrOS6
	 aUb1rR5KvRQbRpGWBsjNXvrznmHU4B6wV3Uloopu08YXd/SircIO5INeRpmXB3UvJb
	 +swS7lln1LQZ2i4aFuG4e2KUTP8ktXnPqRjqN3bBsk89BUCbp+GhEnkxlsS0pJNSz+
	 /Bj6Ns3Mzu0cJlO6Zb0vUanYU4Xy7iJ1zUFksVOTiu8Ew/jDms7MKheR8Mnde3CNKH
	 1jQwlSx3hZD9Z9aZIWo9JEThd7RN8wRd7prFQTuYlRDOhOa/+aSz8bQZVuWYsuiIiq
	 4HvVxFCE+iInM2AQlX1598+g=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kB2UhQgqc4ft; Sat,  9 May 2026 08:37:48 +0000 (UTC)
Received: from xtex1.localnet (unknown [89.251.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat,  9 May 2026 08:37:48 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Rebuild mode for tail-pack layouts
Date: Sat, 09 May 2026 16:37:43 +0800
Message-ID: <CgjAP5WSSE2vLMZi0oabUw@envs.net>
In-Reply-To: <38546371-df53-4fa2-adf1-26ab2dd71542@linux.alibaba.com>
References:
 <Jk-rGy7vS2y1kZoygWQp8w@envs.net>
 <38546371-df53-4fa2-adf1-26ab2dd71542@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 447ED4FEC0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[envs.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[envs.net:s=modoboa];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3388-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[envs.net:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xtex@envs.net,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[envs.net:mid,envs.net:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

Hi,

On Monday, May 4, 2026 11:13:23=E2=80=AFPM China Standard Time Gao Xiang wr=
ote:
> Hi xtex,
>=20
> On 2026/4/30 20:09, xtex wrote:
> > Hi!
> >=20
> > In erofs_rebuild_write_blob_index (rebuild.c), only
> > EROFS_INODE_CHUNK_BASED
> > and FLAT_PLAIN are implemented, so when generating a metadata index with
> > rebuild mode, the sources cannot use tail-pack nor inline data layout.
> > However, disabling tail-packing can lead to great disk-space waste in m=
any
> > cases, especially when the file-system consists of a lot of small files.
> >=20
> > Thus I attempted to implement FLAT_INLINE for it, only to realize that =
the
> > current chunk entry formats can only represent physical addresses that =
are
> > block-aligned while tail-pack extent is not.
> >=20
> > I wonder what do you think about adding a new chunk entry format? And h=
ow
> > should it be named?
> >=20
> > I would suggest the following structure:
> > struct erofs_inode_chunk_index_tp {
> >=20
> > 	__le16 startblk_hi;	/* starting block number MSB */
> > 	__le16 device_id;	/* back-end storage id (with bits masked)
> >=20
> > */
> >=20
> > 	__le32 startblk_lo;	/* starting block number of this chunk */
> > 	/* new fields below */
> > 	__le16 startblk_off;	/* starting block offset */
> > 	__le16 reserved;
> >=20
> > } __packed;
> > The 16b offset should be enough unless we are to support block size > 6=
4K.
> > The reserved field is added for alignment.
>=20
> Sorry about the late response.
>=20
> Thanks for the question.
>=20
> FLAT_INLINE can be used for index rebuilding, which can work with
> uniaddr (or mapped_blkaddr) since the blkaddr will be mapped
> into the relative address based on the blob starting with
> mapped_blkaddr:
>=20
> https://erofs.docs.kernel.org/en/latest/ondisk/chunked_format.html#device=
=2Dta
> ble
>=20
> But I agree the expression in the page above is a bit
> ambigious through.
>=20
> Thanks,
> Gao Xiang
>=20
> > Best wishes.

Sorry for the late response and thanks for your answer.

I am sorry about that I didn't get it.
In __erofs_map_blocks:
> map->m_pa =3D erofs_pos(sbi, startblk);
and
> #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
It seems like that the mapped PA is always block-aligned? However, the last=
=20
chunk of inline data is not?

Best wishes.

=2D-=20
xtex (a.k.a. Bingwu Zhang) @ Sat, 09 May 2026 08:24:53 +0000




