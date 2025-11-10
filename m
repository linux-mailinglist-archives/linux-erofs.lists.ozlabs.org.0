Return-Path: <linux-erofs+bounces-1359-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 29082C452A4
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Nov 2025 08:06:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4ggS5P7xz2xqL;
	Mon, 10 Nov 2025 18:06:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762758372;
	cv=none; b=UHe1WP2EPBnJi1c3qXYuf1NFpR4i4uR4g0p3olotvG8ICp29lqNmI9NpKPekigJbwlDyGq2z1KCcOEZMG5BYWc4HsrQs6OMOCwAb8kgqQGthgqfEnfvTcLW+dgQRUjOKHkTlkSSQvjkLeg/OFpyLSVN2SAJymQL4hxzfjytLIAr4MJt3loftTJ8OMsZevb0yJK+dfUEy+hiwftC4boHjj2LmyIUEE9k/55ryqUlJe67bfZaikenYdcZ33w3WfUMWPR8QYirbDtZa2L1sIvr/pzya7e7xJY6CgKWFcdbWpavDlbtsbR1Pn9SmL4C67pMFem/zSNiGdoQ0K/p4eN19cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762758372; c=relaxed/relaxed;
	bh=31PgdB4PC3UUtx2Cjoo/eEHo62hLYqj1E8vedACmBdo=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=HJ9u1BFo7GuGfPX/wibT21Pjr7AVW1lqB+eV2w82gPeMpq17eDTyrqo4Bw5YX9RoJDejGIO02n0hJYnnR+Vuycx+aMfcvFqJHK5Zl8ZvLxyPx5tfGDa1RVlce15KOJALIMuVPY6G/ex1xYrJpnBRNi8tXzLiynCVt66V559w9hjDEPD0JoaWvJ97VLV0AFPlSxndUOqCf2Lk7yovmVVTqmvuRcBiDOBJcrVwJQyeVyCALnG5JZxtS4uUpnNqfRbKzf8a7OohQmn1QVKuFcUzRpspocnRzwy6RaAtinTQ7xSHm24J1b2erp6I2bkAZzqF0b2Y9wyjce/VWnSAh7wvjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dnr.im; dkim=pass (2048-bit key; unprotected) header.d=dnr.im header.i=@dnr.im header.a=rsa-sha256 header.s=fm2 header.b=y72uloKC; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=O45u58+v; dkim-atps=neutral; spf=pass (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=dnr@dnr.im; receiver=lists.ozlabs.org) smtp.mailfrom=dnr.im
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dnr.im
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dnr.im header.i=@dnr.im header.a=rsa-sha256 header.s=fm2 header.b=y72uloKC;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=O45u58+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=dnr.im (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=dnr@dnr.im; receiver=lists.ozlabs.org)
X-Greylist: delayed 359 seconds by postgrey-1.37 at boromir; Mon, 10 Nov 2025 18:06:08 AEDT
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4ggN2h1Sz2xFT
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Nov 2025 18:06:08 +1100 (AEDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62B287A0186
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Nov 2025 02:00:04 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 02:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dnr.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1762758004; x=1762844404; bh=31PgdB4PC3UUtx2Cjoo/eEHo62hLYqj1
	E8vedACmBdo=; b=y72uloKCbMZdyWD9JzBRmNmF2bhAhT/PsfYPxPnjLyssScpC
	PtYTv8af/erjylqcyni2hgPagjogWjTFLn2HS9Ibupgz2pF1P7ebubRG9mBR05Bu
	LSU/DObppiSG1h21TidOJlfXDnheP0Nu8bhvBo7Ip90/rNhh1I8k0AVhMR1cYpiC
	3DWc7qMIKFsu0cy7cTht9yww2nxfFOQkuU6nv5Yx8ZeB4hV5CaebBzix8WTvC1j/
	R017lp8bJ/IzkDjVo7FmCTSpyvHS4LqGDjLtFA1U0CmHMD1j/TW1CroCBP6XqWzE
	DGfT6D/72ytB5y1+0V+hqUek7d53SJMkaogX1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762758004; x=
	1762844404; bh=31PgdB4PC3UUtx2Cjoo/eEHo62hLYqj1E8vedACmBdo=; b=O
	45u58+vlZwuVqTWWxbfxdI9o0qkjJBuixTXDJTb8sS2oIbbyU9SPgcnzycnJEbEk
	0CwNFoZcNKJ9FNXqnrBfG3DvnoLSUa7eyvuQqImXM/vt8xhaNSartehGQAsonXNU
	pOR3zvQbh4asfDHBkN8r6Ha5vjH0D6CkZY8DufrmiteE5oOZy3lBZVikMMNGfc9O
	D84S2e42PAhw/zBqEUDDjLKytYaJrshXFS3yJBxXbKl0CZabB9cHeumP9T1hYQeB
	Vtljx7ha5J9/mNZIS0OCo/gFuIGEETYhrpMvNLypyIQ24c3u7XICcZcjJOdMeiIl
	xjGNtlZizPKCsRs+dqzEw==
X-ME-Sender: <xms:c40RaZHBM_FsAeg7v9uzIougMuFW2qutCCCG6tFytwhFrcQ9CXBtmw>
    <xme:c40RaZKELD4gTjgzb5rMHXg4x7_AZ3p8loVWFnkYJ391QLVuhKtigZYsBTY_t355P
    7OrcSnlxd4SY8Iv8wXDb2vkqJaOjKhKBvm4jEE-ZguB4UkcJTUJy14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgesrgdtreerredttd
    enucfhrhhomhepfdffrghvihguucftvghishhsfdcuoegunhhrsegunhhrrdhimheqnecu
    ggftrfgrthhtvghrnhepkefgkefftddujeeujeehgfevhffhtedvffefgeekfedvhfeuve
    ejieehueeiueeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegunhhrsegunhhrrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqvghrohhfsheslhhishhtshdrohiilhgrsghsrdhorhhg
X-ME-Proxy: <xmx:c40RaW0lrCh9hU-zwhtBNDTX9OO-NlB4KMh3lX1G5wT1Lg12L0Rnbw>
    <xmx:c40RaZBe3WkwSHI3B-vcS-6dZFnaXJ41fAVtjEws7BPPGFOTKWqdMw>
    <xmx:c40RabyYG6Re5Pesz3NH8iZMsTDWyHx0ghw06yv7PG3yfrmCGf99ZQ>
    <xmx:c40Rafnc80FGBjlLO-QaputdVVCPsUA60_dABhVHL3_10MGHOYX0ZA>
    <xmx:dI0RaQOkkQZtbdF01ZigS44BnRye1bhKfec8rijnOLY9DoI2CS4RbL4g>
Feedback-ID: i263147c8:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 70812240004F; Mon, 10 Nov 2025 02:00:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Sun, 09 Nov 2025 22:59:16 -0800
From: "David Reiss" <dnr@dnr.im>
To: linux-erofs@lists.ozlabs.org
Message-Id: <7d348e6e-d151-4a0f-af86-5ebac804e57d@betaapp.fastmail.com>
Subject: fscache vs fanotify behavior difference
Content-Type: multipart/alternative;
 boundary=ce2db7482eb94f10b3906ea6160a3473
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--ce2db7482eb94f10b3906ea6160a3473
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've been using erofs with the (deprecated) fscache integration in a project. I recently tried to switch it to use the new fanotify pre-content mechanism, but I'm running into differences in behavior.

Here's the basic architecture: It's very similar to a container image distribution use case, with chunk-based deduplication across images. I have erofs images which contain metadata and small inline data. Larger data uses chunk format inodes, and points to chunks in a different "device". The chunked data device is shared by all images.

With fscache, I use one fsid per image, and one fsid for all of the chunked data. In the read hook for the images, I write the whole erofs image. In the read hook for the data, I fetch just the requested chunk (plus some readahead) and write that to fscache. Once the data is present on disk, fscache just uses it and never sends another read hook.

With fanotify+pre-content, I'm noticing that my pre-content hook is called any time data is not in the page cache, even if the offset being read is already mapped on disk. This kind of defeats the purpose of on-demand fetching if it has to go to userspace for most reads. The goal would be to keep the read path in the kernel and only go to userspace to fetch data that isn't present on disk.

Could you advise on how to achieve this goal with the new fanotify mechanism?

If you're interested you can find all the code here: https://github.com/dnr/styx/

Thanks,
David
--ce2db7482eb94f10b3906ea6160a3473
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title></head><body><div>Hi,</div><di=
v><br></div><div>I've been using erofs with the (deprecated) fscache int=
egration in a project. I recently tried to switch it to use the new fano=
tify pre-content mechanism, but I'm running into differences in behavior=
.</div><div><br></div><div>Here's the basic architecture: It's very simi=
lar to a container image distribution use case, with chunk-based dedupli=
cation across images. I have erofs images which contain metadata and sma=
ll inline data. Larger data uses chunk format inodes, and points to chun=
ks in a different "device". The chunked data device is shared by all ima=
ges.</div><div><br></div><div>With fscache, I use one fsid per image, an=
d one fsid for all of the chunked data. In the read hook for the images,=
 I write the whole erofs image. In the read hook for the data, I fetch j=
ust the requested chunk (plus some readahead) and write that to fscache.=
 Once the data is present on disk, fscache just uses it and never sends =
another read hook.</div><div><br></div><div>With fanotify+pre-content, I=
'm noticing that my pre-content hook is called any time data is not in t=
he page cache, even if the offset being read is already mapped on disk. =
This kind of defeats the purpose of on-demand fetching if it has to go t=
o userspace for most reads. The goal would be to keep the read path in t=
he kernel and only go to userspace to fetch data that isn't present on d=
isk.</div><div><br></div><div>Could you advise on how to achieve this go=
al with the new fanotify mechanism?<br></div><div><br></div><div>If you'=
re interested you can find all the code here:&nbsp;<a href=3D"https://gi=
thub.com/dnr/styx/">https://github.com/dnr/styx/</a></div><div><br></div=
><div>Thanks,</div><div>David</div></body></html>
--ce2db7482eb94f10b3906ea6160a3473--

