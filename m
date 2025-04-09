Return-Path: <linux-erofs+bounces-178-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86692A82D07
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 19:01:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXq3F1drNz30W5;
	Thu, 10 Apr 2025 03:01:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744218073;
	cv=none; b=LmrfwqEIAJN4xqhug+wk9bByzWZ6rIGENZeCqXpay86FDo5TGOfoIjwpqPzJWZBA2Zyb6ACLX2swDC5jcDqqs8KdX/y1nfP9k/7H3WodL6PEULuf7oK/wRup/AjdXsgA6QNaJrLEF3jUD4E2CVkcFq+UEoBuJSBg5i7Q6GIRjXSc+juZz9iM0b3PgJpFzaYjqOIe1zdLTe/WyPYv+oDU+oeQZ6NMgCA0k++3PK+jZ7qgaOYHEoBjMG/bD47pUDsfJ4m25rRLqpmZVr5R5BFDLn6rnAW7iGbPacd1kSsfpvxNtzuqXZV/6HV53QfUkUaPllpzocglW9MEyBA/6I+zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744218073; c=relaxed/relaxed;
	bh=CL4ye0q+ZgR9oyb0q5UVNLnXHxRvzPk9CRl1I4YNH+A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gYoeF3UqH2DnEBmLuNs7YNAI3gSeTbGv2QhD6i25V8np+wThEzX++KMug/xoOYjERYsj5uMiy6RjvWtU8YmEDnIXNTOSdkWf3dg7bCEssRBQ3Zh55swCzD6IK1i1Dn9rDPDwT2swocsBpvCYSq85uR+dsOPqOKTsFB43qGf7UaK15vQRSHupFx/i10fnX+FYMLIEGbg1P/JMr/Zy3I7aKWivzV0RB+oYB1waJIEKEHvht76Xk3IAk068E0iy8F1I0GXIcBIXyB3rFF7WMra4fkk64ePqAM+KPtwDrU+kQcAdUp5yiuBzIO30ppUthfUY6kpig79NDQ78f7z7E1pUkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm2 header.b=HuL8J/jh; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fb/ks+7B; dkim-atps=neutral; spf=pass (client-ip=202.12.124.157; helo=fhigh-b6-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm2 header.b=HuL8J/jh;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fb/ks+7B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=202.12.124.157; helo=fhigh-b6-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 545 seconds by postgrey-1.37 at boromir; Thu, 10 Apr 2025 03:01:09 AEST
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXq3941Crz30VJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 03:01:09 +1000 (AEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 537D725400B8;
	Wed,  9 Apr 2025 12:52:01 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-10.internal (MEProxy); Wed, 09 Apr 2025 12:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744217521;
	 x=1744303921; bh=CL4ye0q+ZgR9oyb0q5UVNLnXHxRvzPk9CRl1I4YNH+A=; b=
	HuL8J/jhrt6JxphJS+byIZOFq0OeTG5LHkGGKDLBYZeyaiX4nYCKMXyf6RBEGuvM
	4/wLSEGk8R3Vk3NDlkkUg7ZnxEMKVrM5p0RM2C1zVP7EreYTCC/hBOWNcLuHbIUF
	3NZxS2NyqU2XOHFxHc1C+zb5Dk/QzolGylH2enaW6aFFgRkmGXNuvzIwaFVTzwR0
	L5BcMjgOSxKG891nv+stlPxMkOzrAwruu+4H2l+H+tjWhBofEoa0sISktTtqseYj
	Edb4kSf4wfU8+cb4yR+MaDPoaOCGFQXKBWVlO5RkUJ4E0C/tXaeJvSI8kQnbSKkN
	qVqn98ITxKgeP3Cw9URSJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744217521; x=1744303921; bh=C
	L4ye0q+ZgR9oyb0q5UVNLnXHxRvzPk9CRl1I4YNH+A=; b=Fb/ks+7BOX/aPMGlf
	Y1DIY3V+OcAW222L6P5x4IQNkQ1dBaq4Ur4d+CO+wRsUfcP3SzIQAlp+nzcONcop
	QhyVJddaS2XrFw9B2dsGBDtnHNp/SiRw8ldu4u1arnu5hVUYBd2kexhGMbOhYNSv
	6vVD+oL7HsJWbY/gvv56Bl+LOrJaRnqBRyh9IP+fGeg5vXplGn1+2SP+I1J3umlZ
	Z2eXOzUXPFFATqVlpR2EoqpgUmp6xJcHoINCbcW17OOZbXIkL+AJq6LgcMehHJM1
	fnmKbtJc51dg7NFPF7FiRkYqKQ/oGIN/QeRrK2dL98WAyrtC/nnXjbG0QbC3zIsh
	BdOqw==
X-ME-Sender: <xms:sKX2ZyLBCWlMTeoo5VC4wxp196rKN8HJYviju7DRKDKxzR8nkGPlKw>
    <xme:sKX2Z6Lj-Utk3IEwprK0C6N4xVwQYW9AxjT9VStqyWQzTGljydR3RzcId7ShtcrtG
    pCM9xqlXvKPZnXG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfveholhhinhcuhggrlhht
    vghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrh
    hnpeetffdvudegfeefgfejleevgfdujedtgeefkeetteelvdfgleehteefveduteevveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlth
    gvrhhssehvvghrsghumhdrohhrghdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghlihgsrggsrg
    drtghomhdprhgtphhtthhopehlihhnuhigqdgvrhhofhhssehlihhsthhsrdhoiihlrggs
    shdrohhrgh
X-ME-Proxy: <xmx:sKX2ZyvQoSh0Qxu-ZK7wYOweQaVAdq9WYyIaK_eOwd5EXCPSGX5UXQ>
    <xmx:sKX2Z3awcyRVyRnT8iQVMk00eeXOAyOLAFVe30tYbi_-yD2ocOs47g>
    <xmx:sKX2Z5bq17JoJBp0WYuXXIzV2aQcDlGJek_sugE9aay51_5OUk_n3Q>
    <xmx:sKX2ZzBC4Pl6JP5YLkNNJNv1hz1s6A8TMPzi0Yq9NeNel9B-2zx-wA>
    <xmx:saX2Z3w1q3ULZPhQiteSeIST3fZ12o4CsrNsmBBHCHrQR0Nfq7OQrIjQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E8ED29C0072; Wed,  9 Apr 2025 12:52:00 -0400 (EDT)
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
X-ThreadId: T558f9dd975fc88e3
Date: Wed, 09 Apr 2025 12:51:40 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <0f9fea0f-22b1-4407-98e6-c8df41293b81@app.fastmail.com>
In-Reply-To: <20250409061731.1267689-1-hsiangkao@linux.alibaba.com>
References: <3bc4c375-9a5b-41cc-a91c-a15fb4b073ba@app.fastmail.com>
 <20250409061731.1267689-1-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: lib: fix `1UL << vi->u.chunkbits` on 32-bit platforms
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Patch looks sane to me.

On Wed, Apr 9, 2025, at 2:17 AM, Gao Xiang wrote:

> I think it should be fixed on the kernel side too, yet I rarely look
> after 32-bit platforms due to lack of test environments. =20

It is relatively easy to run 32 bit containers on a 64bit host, that=E2=80=
=99s what the Debian CI environment that hit this is doing.

I think the bigger question here is fuzzing on 32 bit right? That likely=
 would have caught this quickly.

I don=E2=80=99t know=E2=80=A6roughly though it feels to me as long as th=
e Linux kernel supports 32 bit we are going to keep getting pulled to do=
 so too. Especially there=E2=80=99s a long tail of 32 bit ARM out there =
as I understand it.

>

