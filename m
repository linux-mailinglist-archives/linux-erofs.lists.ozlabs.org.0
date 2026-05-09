Return-Path: <linux-erofs+bounces-3390-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EgiE8hE/2mo4AAAu9opvQ
	(envelope-from <linux-erofs+bounces-3390-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 09 May 2026 16:29:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2218B500094
	for <lists+linux-erofs@lfdr.de>; Sat, 09 May 2026 16:29:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCSzm3vvRz2xqv;
	Sun, 10 May 2026 00:29:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=157.180.15.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778336964;
	cv=none; b=SOfZTiuyGR0B9yQPNA9Wr4iUeE0JC/gLEbc/y4KoyF/STpw8RcifZWNCrZgbSrL8t4hSXwVIgMB2izaIiaC2hYFFCzrp/9sQhq+JpryXpLS8J1iVOaXAydyZ4VRoBvCGE2gN+sEPmyQrW1DNIRKVEiIi/rofyR+9u2826jRB3GK/PCDiC9as3+n/z7pySl5gDIfnEjrTEc+zdhahqUabUlIcSQhkM8qreKrBlFiAqxSv/qjsylHhGyQubgHDdkmnWnQqukYCOPQ5AnixbdsxKKaNsbO7r4lv04leDGSB/9HqH9PIv97jAoCXkeBouBmxay+5X2lr+swRNDPgEsWmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778336964; c=relaxed/relaxed;
	bh=0mSbgHixmfxSCxbmEllLPYhX9vdiPNagI1vOIlCn6qA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhgUYcHYrNDImK5DiiY393Vyt8IWscpHpRH8wmGSbxbT/CwMFgN2RpGvbYpzJHTWtPZHU9PSG1WuYjVEiNfFaRrEILiGu2FH0hnCaisQEOwC0MYaEahk38FXkCwGLRTAQ9C8TriRwnZ9Q1RndF0U8U11CxaS0jJyN7I56q1XTQL3zH7G+35cFUQV4F4WF+DX4M/ilMmY0+4fQDiS1XnR9PlBReUMI0prpZv4wCqq9kPeaMkKdHLnPCguZ/vqgNGHQotbXNY4OcmcjairHDDVUhQSbkYtvpYfysuSgsHj3pzujfAE4qWwyxP9CCHiCSWLTITV6s72AMdR8OUcj/wSvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=WowBxIN1; dkim-atps=neutral; spf=pass (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org) smtp.mailfrom=envs.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=WowBxIN1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=envs.net (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org)
Received: from mail.envs.net (mail.envs.net [157.180.15.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCSzl45Pnz2xf8
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 May 2026 00:29:22 +1000 (AEST)
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 6DAE71C00D5;
	Sat,  9 May 2026 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1778336959; bh=0mSbgHixmfxSCxbmEllLPYhX9vdiPNagI1vOIlCn6qA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WowBxIN1/1O65M88RuJOoobODtmO3+fyIDrgxC7jrOfFSbLauMh4LugA6UkFgaPOE
	 DPUJwaHXo7YwVLgYmE3bojre/JAXEfmFBpBTRePXCVPCoFovt/imow2hILr9RqGqHq
	 U7ArHystApRGvADv2uv9j71f+3LJhs7ccfL5ZSVuU73Y9u84SSEpM2bxopMI3g4pxT
	 Q49TQLVE51IIbbRrdx23eFRB0TFZZg3lvyOtY+zerILz1xuFW4GT0bbISv/xQp+Knm
	 wpwqLfKZPyB/aR8zvpet8naI9EJdkWjED71v8xNEbZN5P6dewvYaT/R4iScf7xHaIl
	 /1CKfssNvnNxA49SYt7V3GeZ8gGzWA1MmJ00P+ZejEj1zQlczevB+sNaY+EmY9rh3p
	 QSTMwTs2ydCxG3PMoQYBS5K8eG+qnYQAyBCqEyVLr25ibNXVjtOsdPNqJRGYroChPV
	 X3Fm8L2Cod9aifbIal8XpApllDbca0piXQYnK1o6CUuAmeoS2dogDR5rAt276CM5XT
	 +ES7lX9aMX04umDm+w1zT9Y8qHmOKNZ+RcTzF9Qo1JhgRP4QXugBOuh6FK/2PEFrgy
	 2sNBfds3OSawZH5IflTrijgypYedN6ELYCDW/8xWU8j+8Tp7WYVCbtIwJFKfHkmRns
	 bAlZS9/YE0cpMI+azkCZArYg=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FLeEMuZdUIVD; Sat,  9 May 2026 14:29:17 +0000 (UTC)
Received: from xtex1.localnet (unknown [89.251.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat,  9 May 2026 14:29:16 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Rebuild mode for tail-pack layouts
Date: Sat, 09 May 2026 22:29:11 +0800
Message-ID: <5qBWw8PlSaWgKruL4DxpGw@envs.net>
In-Reply-To: <af8GY7GTdIO4G829@debian>
References:
 <Jk-rGy7vS2y1kZoygWQp8w@envs.net> <CgjAP5WSSE2vLMZi0oabUw@envs.net>
 <af8GY7GTdIO4G829@debian>
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
X-Rspamd-Queue-Id: 2218B500094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[envs.net,quarantine];
	R_DKIM_ALLOW(-0.20)[envs.net:s=modoboa];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3390-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[envs.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xtex@envs.net,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

On Saturday, May 9, 2026 6:03:15=E2=80=AFPM China Standard Time Gao Xiang w=
rote:
> On Sat, May 09, 2026 at 04:37:43PM +0800, Bingwu Zhang wrote:
> > Hi,
> >=20
> > On Monday, May 4, 2026 11:13:23=E2=80=AFPM China Standard Time Gao Xian=
g wrote:
> > > Hi xtex,
> > >=20
> > > On 2026/4/30 20:09, xtex wrote:
> > > > Hi!
> > > >=20
> > > > In erofs_rebuild_write_blob_index (rebuild.c), only
> > > > EROFS_INODE_CHUNK_BASED
> > > > and FLAT_PLAIN are implemented, so when generating a metadata index
> > > > with
> > > > rebuild mode, the sources cannot use tail-pack nor inline data layo=
ut.
> > > > However, disabling tail-packing can lead to great disk-space waste =
in
> > > > many
> > > > cases, especially when the file-system consists of a lot of small
> > > > files.
> > > >=20
> > > > Thus I attempted to implement FLAT_INLINE for it, only to realize t=
hat
> > > > the
> > > > current chunk entry formats can only represent physical addresses t=
hat
> > > > are
> > > > block-aligned while tail-pack extent is not.
> > > >=20
> > > > I wonder what do you think about adding a new chunk entry format? A=
nd
> > > > how
> > > > should it be named?
> > > >=20
> > > > I would suggest the following structure:
> > > > struct erofs_inode_chunk_index_tp {
> > > >=20
> > > > 	__le16 startblk_hi;	/* starting block number MSB */
> > > > 	__le16 device_id;	/* back-end storage id (with bits masked)
> > > >=20
> > > > */
> > > >=20
> > > > 	__le32 startblk_lo;	/* starting block number of this chunk */
> > > > 	/* new fields below */
> > > > 	__le16 startblk_off;	/* starting block offset */
> > > > 	__le16 reserved;
> > > >=20
> > > > } __packed;
> > > > The 16b offset should be enough unless we are to support block size=
 >
> > > > 64K.
> > > > The reserved field is added for alignment.
> > >=20
> > > Sorry about the late response.
> > >=20
> > > Thanks for the question.
> > >=20
> > > FLAT_INLINE can be used for index rebuilding, which can work with
> > > uniaddr (or mapped_blkaddr) since the blkaddr will be mapped
> > > into the relative address based on the blob starting with
> > > mapped_blkaddr:
> > >=20
> > > https://erofs.docs.kernel.org/en/latest/ondisk/chunked_format.html#de=
vic
> > > e-ta ble
> > >=20
> > > But I agree the expression in the page above is a bit
> > > ambigious through.
> > >=20
> > > Thanks,
> > > Gao Xiang
> > >=20
> > > > Best wishes.
> >=20
> > Sorry for the late response and thanks for your answer.
> >=20
> > I am sorry about that I didn't get it.
> >=20
> > In __erofs_map_blocks:
> > > map->m_pa =3D erofs_pos(sbi, startblk);
> >=20
> > and
> >=20
> > > #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbit=
s)
> >=20
> > It seems like that the mapped PA is always block-aligned? However, the
> > last
> > chunk of inline data is not?
>=20
> Yes, sorry I didn't express explicitly.
>=20
> I mean the main data except the trailing inline data part
> can be remapped into another external blob.
>=20
> But inline data should be kept with the metadata; otherwise it
> won't be called _inline data_ anymore.
>=20
> Or do you have a case we have to redirect the inline data?
>=20
> Thanks,
> Gao Xiang
>=20
> > Best wishes.

Ah! Thanks for your explanation. I initially thought that copying inline da=
ta=20
would increase the size of the metadata. Thanks!

Best wishes.

=2D-=20
xtex (a.k.a. Bingwu Zhang) @ Sat, 09 May 2026 14:27:41 +0000




