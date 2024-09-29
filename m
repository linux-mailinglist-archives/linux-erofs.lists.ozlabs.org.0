Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD8D989496
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 11:38:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XGfJS5h2Rz2xqc
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 19:38:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727602677;
	cv=none; b=CIeSvf66sdvoxf1MW9rNJo6BpAofPE+cqhfPK67HZjl0Sntu2FGDlhSJTQGJNf5xmBeB7aZEJ83tscGwRKHZcvwDi5+c7QTBKjm0NoaK74brItj/Up+BiPVJLvsiZ0HVzeMpUjmX/eGeKCe3Pg7PEIOIe0QdUX01JvsTF0QPzDU1E3eUDNgTWKDt5CVBySGLDEgY/U1/OTIjs+ei++OQpbJKHC/5vR2K9aBcCpah0G7t7I9cMV9Phki3X3oDai+1+1gZGHqzpoXSFLLJSZWogqVrSYfiB3cOR44tyZhOSwYNjnD/v6j1hpfurp0oxs8PR9ltlgvnj2N20bWSUIVm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727602677; c=relaxed/relaxed;
	bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7a98su8/GTYGfjCStS2+ksIpf63cbBufb5y17jzJMb7FYd14tMQFX2W2qCkmfbRKnf0A3zIKKawdVWmarLzemAOzgE+dez7Y7St6KFyGjf206NSPtDAfopsuvtCPQ3m5r9T5wpSzM8g94ycggb1BuCizbiefaPc5PNen875KIpddsLaig1Dekoa7SyDMSFqdGIJTTEAvtNKgGso/RukQniaqoxDfY0P37VuUSc+2mbV8L6KXuZQ5X/fKL5O6/Rkkj9bSzcyRsKqizf1R3YvQ7Tr0+5RUKyUnWQVvG9fi4H064tFtvGvo/OL7bAG4VveJAD9lMxO9TmlyfXOSpOL2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d44sMXHK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d44sMXHK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XGfJP20hxz2xg9
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Sep 2024 19:37:55 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so2634576a12.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Sep 2024 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727602670; x=1728207470; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
        b=d44sMXHKkCaN6cuVPN3WORku46sAR9mXY0V5WUkYCB+kcEHGt376F37BGIn++c8hOW
         igCLCifeoLRwMafExrY7XcG/9KH3GjUR9VOPVIyNHTXbvFzrjQF/iqcdyEjW2xZWRaQg
         62A1QVsdVjW0w3hzastf7qeFFwBzIxDme6MJxSAp5UvkhzAvS82APXaEK+2Frw/VC+aL
         ZJMHDr9OQUwBTLHsuAFjTIBEgEazZxX7Uj8I4h6VPqed59+maedPEH3xfT1afG/oZOvR
         QmwQlgM6gYnoWbBV00jrmVSPRdmrrohwIhDEk7yNgLrnYge17i//OU+aVh/HO5nLBr5a
         tAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727602670; x=1728207470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
        b=cgmkqKBz1k9PvG873zOHupaXNYACjQF3/ilU5odH9u0mbcDvzaPu0AU7VHQkSc6pLX
         UeryjOlfzWdMWoBanffxWFTCMrsCK50khbY/7DZI9H8p+HyqWzosTmFaZhtsIBY4KvYO
         AGhks25yiJ4+bDZfYxquEY57h825ob8opK0YCwfHW9BaZiayxfahNWwa22f82h2hf14x
         LLo8dj6Na4RbjEZRw5RolFOXdM2u6VFWV7A69aNdoMFXfnMp01K9TFrt3Mmy9BwZCCwx
         GFtXt3NoupB7qygdnkl3mKun7C3eowXjhkqgckMsBgIZ69O2zsACcGiuv2Dwrc/4agSQ
         9/4A==
X-Forwarded-Encrypted: i=1; AJvYcCVmyZCDfbt4oOptE14qq+F7usLNWB7V4+NnUFkyik1ZhEBcP/5CDsBm8QrNuWjCNP22oP8q+vDrfu4bkQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8xA+GsOI7MCE+KMUoJd0grERqJzZ7SywvS2vrSb8aqloZYFyL
	keNi/zI29CeapSbaneqLAOQ1BXuxLrUKK/fayPF5UE6+A7dK4nuG
X-Google-Smtp-Source: AGHT+IGlIri+CO3nO7SHxYS35QDjVZ1ed/TCsk0eNd1dMV/4gMLjT42I+WIsw+2rLAY8Xe2G636KQA==
X-Received: by 2002:a05:6a20:cf8b:b0:1d2:e81c:adc0 with SMTP id adf61e73a8af0-1d4fa7b53bemr13375412637.46.1727602670436;
        Sun, 29 Sep 2024 02:37:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bebedsm4292766b3a.85.2024.09.29.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 02:37:49 -0700 (PDT)
Message-ID: <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Leon Romanovsky <leon@kernel.org>
Date: Sun, 29 Sep 2024 02:37:44 -0700
In-Reply-To: <2808175.1727601153@warthog.procyon.org.uk>
References: <20240925103118.GE967758@unreal>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
	 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
	 <2808175.1727601153@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, 2024-09-29 at 10:12 +0100, David Howells wrote:
> Can you try the attached?  I've also put it on my branch here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

Used your branch:
fc22830c5a07 ("9p: Don't revert the I/O iterator after reading")

dmesg is here:
https://gist.github.com/eddyz87/4cd50c2cf01323641999dc386e2d41eb

Still see null-ptr-deref.

[...]

