Return-Path: <linux-erofs+bounces-165-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D771A819D0
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 02:25:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXNyX0wx1z2yrP;
	Wed,  9 Apr 2025 10:25:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744158340;
	cv=none; b=otAnVP38KdHGoElnkpwSRRDvjk4bcR07XV2mVkRiJrJ4vY0fCOeo9xxbPf8zd2mmEjAfT+vefnA67VbuaTElOifmUmqGjx5Cbwoj5fJPteXXDk9e3tIRULrCUBbItAujBghjajT0dDxENQpLgK9UeJNtVZQqDr7DVwSEZbSYzzJpmyugQStkMaLRXCfmv3GcHUu3Z6MWSwofX+mmN/alruai1f/rGH96GVO+zg15zexwrgxLCXzWsv9Fm8sbp5gn/upAE638jj5Qhgx4vdxgm7htbxvwHqZuc2iI6L9A4IscMSlnH3hwxmXEFpP218fCh5sP6ucY7L0JbW7qoYWSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744158340; c=relaxed/relaxed;
	bh=tNLe/niBXhF+lvBq6bxoy1YSbLvRwGasZxbEUsXz47Q=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=lYC4hHyxeh31tG3ESYhdfrP+p6cBBZgMDIlMsNyhvoQnTP4WMLVH8btGy+8LFhQpM4gXMV5dpJo9LOtz5ld+I3TfiViDF387M903IWx7fbL10ZA3n1mED/3h+Rubuc5P8g+eOcuuwyCutB6Fd9jjT706WeaQCNSlFLhxV2wolgnCfv0bEerpkPlwGNtV4Tb8oYN0S9LammQfmnTg75RfS5hZfUFjgg+8wi/zwMgmbG5ur4MTIYNIdHy8zjgF4L3rpW+MiGsOrjmjI4vNmDuNS8YBwVMLCF69ut2NeRQ/xLOziAeMP9XenM+TFbCWrKjD5uZy6NmuawKD/mxhhFqN2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm2 header.b=ABaTj45N; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Vw/Pntvt; dkim-atps=neutral; spf=pass (client-ip=103.168.172.153; helo=fhigh-a2-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm2 header.b=ABaTj45N;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Vw/Pntvt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=103.168.172.153; helo=fhigh-a2-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXNyT4T4cz2yr7
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Apr 2025 10:25:36 +1000 (AEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ABBF1140214
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 20:25:34 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-10.internal (MEProxy); Tue, 08 Apr 2025 20:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1744158334; x=1744244734; bh=tNLe/niBXh
	F+lvBq6bxoy1YSbLvRwGasZxbEUsXz47Q=; b=ABaTj45NQYD+MqwYNSzpr4YiVc
	S36OVf+ihDTuql0y4i/bN0BydXP10jZBDLUlLV+UvwsVclzh6Zs6XWNq+qwUz65b
	8S8jaFB/F3HE/xp/lqbm5fy5mxaHobmXqmDBG1CZc+ITuUlehFr9+Z6l4hzfTUyw
	2+c1x+C+cRyleBiDSU4z4MOLhLufbWnL0rzutajdfIuQRYtnyRApU4utngp9/XjP
	l0WhDjO54VNqPOfKLvYDZLNdeCm2OEiXaLRxe3LUkJ5omxLjMo8CWyNSaXzH5rht
	JDBcWp9RpVgGLbCcUDo/c9OQ5kHtIZAcrAS8qLIZJBQFhCfyfCiTal9ctZuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744158334; x=1744244734; bh=tNLe/niBXhF+lvBq6bxoy1YSbLvRwGasZxb
	EUsXz47Q=; b=Vw/Pntvt97LJEeP2oEJF9k9hXQKe/N9y5cPVSP+bC2KTgQ9IU76
	EJMA0iRmLobwzsUIULhX7KbVbZopzj6MAPDCaYTHTEFc1ZQl1mV0BOkvUwMZhssU
	qn0KUnUQjVfjB6evoL0OZj6OYcl90muIBy8tyHN+vezbi/0orRihzxbrxg4sdqc8
	wZrFTiaPTJ+sPwJXMUfgiiMBCyaT8JU28oqSJBPxt1GbUmMDKhJFWHViVfzJexOT
	U9LwK9r49BZg37A4aHquhE3jQq2yhRrmaYCzSK337T5p4XaWrzSumjxGpEGj+fwY
	finXqnJdR9hNSLsFUhzhCUf6A0p5FkzOLbw==
X-ME-Sender: <xms:fb71Z_8GxZoFzgJTtRjhZIb10UR1wIz0sqGBsdQCG65kWyGoLIr1Ew>
    <xme:fb71Z7swN8f6x01QQeaSMGaS92RIBNNE3_f9UrLJyaZal-lc-dEw3bR1WUzu1eSoz
    gMLUQ8D5rN1an5x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhinhcuhggrlhhtvghr
    shdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekuddtheeihfeuudeiueevtdfghfdvleehtdduvdfgjeetkefhveeihfetlefgtdenucff
    ohhmrghinhepvghrohhfshdrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgvrh
    hofhhssehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:fb71Z9AZDHZEoSaO42AjoU1nG8O0mw3ObKNvImCAAEU69Zw2lQv2iQ>
    <xmx:fb71Z7dJ-5Ib9PcUcUfSDzgYg1pz6OjqZuKRMhB-x8qYDjnn-YaEPQ>
    <xmx:fb71Z0ORMDw2_8CAo0FLaJGAZGI4x4IXQCXziAL0lAx_OoitMo0XaQ>
    <xmx:fb71Z9mn2sdkm--jWLi-vyhYkARU0IPmh3oLt1HFaQhvRCfwLNULGA>
    <xmx:fb71ZwmQtTRPjytcmsYkbVBsBVnI82UrpL39M7ROks_9hTlqaTL8M9Wv>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4717229C0072; Tue,  8 Apr 2025 20:25:33 -0400 (EDT)
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
MIME-Version: 1.0
X-ThreadId: Ted543d6ddafd7fb6
Date: Tue, 08 Apr 2025 20:25:12 -0400
From: "Colin Walters" <walters@verbum.org>
To: linux-erofs@lists.ozlabs.org
Message-Id: <3bc4c375-9a5b-41cc-a91c-a15fb4b073ba@app.fastmail.com>
Subject: fsck.erofs infinite loop on 32 bit with large file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hey, we're working on shipping composefs in Debian. It runs the tests on 32 bit (i386), which we don't do upstream.

As part of that, we also run fsck.erofs. It turns out that there must be some bug in fsck.erofs on i386 because it loops infinitely on the filesystem generated by this composefs:

$ cat ../tests/assets/bigfile.dump
/ 4096 40755 2 0 0 0 0.0 - - -
/bigfile 9000000000000000 100777 1 0 0 0 0.0 - - 
$ ./tools/mkcomposefs --from-file ../tests/assets/bigfile.dump /tmp/out.cfs
$ fsck.erofs /tmp/out.cfs
...

For convenience, here's the zstd-compressed erofs in base64. I didn't try investigating this at all yet in the erofs-utils source, but I can help if need be:

$ zstd < /tmp/out.cfs | base64
KLUv/WQAT71EABpzNBceENDSdP//////nzsHR8goVME0ERERwQ+79f3gp793uQE4AVoBz1SepTxD
eXbyzD6vz+kzk2clz0iejTwTeRbyDOTZxzOPZx3POJ5tPNN4lvEM49nFM4tnFc8ontFn85l8Fp/B
ZxPPJJ5FPIN49iCXOcjlDRjfjRMXDtw3b924bdOWDds1a9WoTZMWDdozZ82YLVOWDNkxY8WIDRMW
DNgvX7147dKVC9ctW7VozZIVC9YrV61YrVKVCtWpOzsrdWuqhaVy5w7c3d2ZsuAty6tvZe69Zu4u
3R1QitQoUaFAffLUidMmTZkwXbJUidIkSZEgPXLUiNEiRYkQHTJUiNAgQYEA/fHTh88ePXnw3LFT
h84cOXHgvHHThs0aNWnQnDFThswYMWHAfLHz0oXLFi1ZsFyxUleFyhQpUaA8cdKyvVVNmzBZoiQJ
kiNGihAZIiQIkB8+evDYoSMHjhs2atCYISMGjBcuWrBYoSIFihPoaZbkKIbgZ6IEiREiQoD44KED
hw0aMmC4YKEChQkSIkB44KABgwUKEiA4YIDXuQCBAQIC0AGYuxzGGBLZsVuupFbqStilU7CwXOou
nuPdUbu7mztwr5wLaZfuAOTuhpvvvXT33ltMm7FjF9fyov4Jb0JvQW9Abz9vPm89bzxvO286bzlv
OG83bzZvNW80bzNvMm8xbzBvu3eX95Z3lveVd92bylvKG8rbyZt9r+/0zeTUfSt5I3kbeRN5C3kD
eft483jreON423jTeMt4w3i7eLN4q3ijeKNv802+xTf4NvEm8RbxBvH28Obw1vDG8LbwpvCW8Ibw
dvBm8FbwRvA28O53gfeAd4A3gPff+PnuWdwzuGdvz9yetT1je7b2TO1Z2jO0Z2fPzJ6VPSN7NvZM
7FnYM7BnX8+8nnU943q29UzrWdYzrGdXz6yeVT2jejb1TOpZ1DOoZ0/PnJ41PWN6tvRM6VnSM6Rn
R8+MnhU9I3o29EzoWdAzoGc/z3ye9TzjebbzTOdZzjOcZzfPbJ7VPKN5NvNM5lnMM5hnu+cuz1ue
szxfea4LIAv2wBVUwRREwRM0wRIkwREUwRAEwQ9sP/brfeunfumHfudnfuVHfuMnfuEHft9XokSJ
e94ITOqeFwKPuud9wKLueR1wqHveBgzqnpcBf7rnXcCe7nkVcKd73gTM6Z4XAW+65z3Amu55DXCm
e94CjOmelwBfuucdwJbueTxc6Z6XMaV7HgE86Z4nAEu659HhSPe8OQzpnieHH93zsKP7Hocb3Xc4
zOi+v+FF990NK7rvbTjRfWfDiO77Gj5039WwofuehgvddzRM6L6f4UH33QwLuu9lONB9J8OA7vsY
/nPfxbCf+x6G+9x3MMznvn/hPffdC+u57104z33nwnju+xa+c9+1sJ37noXr3HcsTOe+X+E5990K
y7nvVTjOfafCcO77FH5z36Wwm/sehdvcdyjM5r4/4TX33Qmrue9NOM19Z8Jo7vsSPnPflbCZ+55U
5uJm9Fb0RvQ2FPe2Ldv22rVV27RF27M127Il27EV27AF269tWZbtsSursimLsidrsiVLsiMrsiEL
sh/b9ther7f21F7aQ3tnz+yVPbI39sRe2AN7X69d2bW3rqu6piu6nqu5liu5jqu4hiu4fis7BUrr
BIraqqzaU1dVVVMVVU/VVEuVVEdVVEMVVD+1Tdm0l66pmqYpmp6pmZYpmY6pmIYpmH5pi7JoD11R
FU1RFD1REy1REh1REQ1REP3Q9mTP3rme6pme6Hme5lme5Dme4hme4PmdrcmaPXM1VTM1UfM0TbM0
SXM0RTM0QfMz25Ite+VaqmVaouVZmmVZkuVYimVYguVXtiRL9siVVMmURMmTNMmSJMmRFMmQBMmP
bEd27I3rqI7piI7naI7lSI7jKI7hCI7f2Iqs2BNXURVTERVP0RRLkRRHURRDERQ/sQ3ZsBeuoRqm
IRqeoRmWIRmOoRiGIRh+YRuCG6hCyAmvyAtSJ+1n0gwIIUQYIdQPEkgAEYRXgCAIgiBCQoQfPb8q
6RCaWc09UkiDs70qS76wCOPftiaMfBFgEqhZUyV6YPPXn2GJlHimU7ejkZIQfudyyxOjQh1/5Zgj
L0NZe0vOhHsah03KX4lrmIxrAq5T+k/ME2WcFGinkqdiHCvjrsCLlXwW82yZxwXarvS9mANmvDBg
xdI/xpwy05kBe5Z8NMaoGW4NWLbUtzHmzXhwwMalX44xdKyfrh7hU/2soo5VttX4rnJgxRcrVhb6
WTG1xLMlews/rhhd8u3a5QV9r86vecDiBgsvLA8xvGJpjYk/JicZnLKwy8QzW+MM3LNcaOOj5ZkW
jlreavjW0mCTl01XG/xtMd3k87b7DXpwGXHjjYslF3y5mHPo0MWmE1+dDDt87WLdyf9uJx508rrz
5tOLYy/cvbz48POl2SeOn9x+8P7CABQXcK1A8ANzCo4zmPdgeIR5FOItTMtQfkOdh/AgxkaUX+IO
RegqZi2OfzEmY3AaYzei5xjjUbyPsiDxh4wZKR/J3ZLQm+ygnJcyrsrwK/O0xHOZ9qV4mHJkws0M
S1N8zTU3weHMzTleZx6e4Xrm9Yn/M01QeUJ1h8InGmNUvqO7SKFPmlk6HtPYpsE7jYGKLmqsVPGn
ylTFZzX2qvxYd7RCt7XLdX7XOF/Dgc0bFl9sGrLiyso1C382TFpxanf6dPlsqQPTUbTTc4eg34kB
LQmfNawMtipNjzpbqJMUNlTskmwpfNTYI73xTgpT/kMb2gekllj5QLo+ciaTAso/Lg2gzMBhaoaq
XxpjFBmUog+VLdRZRR+6ekiXFDZo5LFMLfjQyUu51bCpIodkSeODVhbLlaZHnS3USQobKnZJthQ+
auyRXi34UNFCmrS0oSOXdGljp5Y3/vGLUTMigNYA/zBEeAjmCwHZ7x+YnFm+4jw=

