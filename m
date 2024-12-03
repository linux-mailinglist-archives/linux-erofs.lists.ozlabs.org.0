Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB89E14F6
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 09:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733212979;
	bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=T2JlwdNxbx5JlAZxnVX0Qc+jOZTpnuM5EienO6pHtCpU1utmnVfwTUYe8oUS3rOdD
	 9cFdAQtWk1HrD71KUz43sKlpb3lavRfSp5k0SL6uBLuVDEo3hIv74UH53mcGOUlOoT
	 Cn2jhbQHXbDwkMi6XamITjBsWNtPlblmfCN6xsAveMHglTziTix5AMHS84f6+obMbM
	 tQu8C/+bbK2jG9KUj1t8+UjTTmRAj7jSl4RV6wPyRzwpX03YrkvXhMnrCLflWcNrL4
	 EuF+V39EEnpjoxy1cSey7yRVVy9qtQDHcETNjhZ9HpuWJpWHFK774W13Th/tQCiZNK
	 3ojmPyQCW6dSg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Y6q42s1z304Z
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 19:02:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733212978;
	cv=none; b=FP2uuSbilRKGCKnghXs3W4vbR9yH86k1AIR6Cu3SKHpQq0phH6Ndj/oz13FD1P0/ozY5TarpXLsm/0Kp7Pzd5u+TipqdORQnZCJ6w6rxAYeXHH7y9P8jItFaC9GuAKOb49XXKzaXyFEr61z6VgcJzhNNEPjziaKgK96hbzTnvJa1kmnLASUNkeItrB132PantmkNv9W/iCRR8ga5Fs1TLw3E510vuTlo/NoZ5s0R6gbCHxMvCn90rDLjlqbw+d931dSFKpzvaqxmAwI/9HCbPRXoEaD1fv/0tzGL01DUfa2yVQzf+GmGr6hrZqnzq9MGEhJYnMAJ1ztFpJNt3zsnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733212978; c=relaxed/relaxed;
	bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QegDXdHaTBHOsrp3oqMswB9ae+Afra8GqwpXn6YGqnm6aIw+9T585uevUEYRPmobIhXZEM9UdMtqQaQpYnlCGITArgAxPGn1suZZZlF6xusH/CksoAuJBwHPAyUw6WSwJ5d4nfg6CrBFggHZTIRoFybLtnkJoYLYP4gjWczJvQ+AnzR3tPM9T5DBLlZVjIBk8lBBiazm08QHCfqQaqqV42BNYbAadgNKQlAUkXMbM1h71L6guuNAQIPDrzuJuStIgF4OJFIVflbcfLAaDrUPCtXrZ6RSOOaS/6HTfjdrV32bMJSP58Yt9/GlnTS2a55WchRULmi1aehVR3kZc8QxJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=DyQeBu5s; dkim-atps=neutral; spf=permerror (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org) smtp.mailfrom=ionos.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=DyQeBu5s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=ionos.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Y6l5wwcz2xfB
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 19:02:52 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-aa503cced42so763524866b.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Dec 2024 00:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733212968; x=1733817768; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
        b=DyQeBu5skbtCFRJ9Pv/HRmln8CW7+ADhN+BQb4j1C+fJOg46MQTyz3Gu6+SM5z0/m2
         zlK0pmCZA315q/U5kOHfViJvn1/U2DIz/eV1UoTKlIHPo4Pw2PFhbHB6uy5wEsqyBTSS
         XtRBoaLFX3Mjn/PNvOYn3xXVmbtvlaWZ4kPO49P+h014Y1YG9JKmxbw2wJK338bHiL5X
         u/3OegZ8t6J4iDzVzzbDDncZ7V8NIZcPbeODG3caTKoEo0AZE4qns2zKJczEpYAvqL0p
         vP+u1f4Njs9OttdEwdEl2Kxq2I1BFhshUzV83PQrAG43Po+z1rAaPDpGxODGZ5BmzoyM
         eN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212968; x=1733817768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
        b=nwYXdQ87R40dEUUWVQ8OwMnwSMKYubpQivLuvqTUK7k65p8n+WOKdjtbVYVEnkUAlM
         eGmpUuvw4zYGjJuCzcgY3lEHN/uOok6Jbo8g4mIyuXkrle9AV7wbd3+VFSCKy19yXEhf
         ZupHvNL+Q9KxeVVvU6U0DweOZ2y3euQcvkAl+00noKUwwtnmJWWuGlb9Kt8mTcdFE9i3
         SF9hNq4vOX0XjF68uoOprZfmdUC85zwVK7Hj+6OfCsWqRHReyY7GWjUhyUixL3BwYGhz
         L9tD+jNBAXfnmdGULnY2nYZ/7Ss1ldjPWDxQnDr2yX5kRGvc6KTIp6K+2tfWPRYzGAYN
         y+3w==
X-Forwarded-Encrypted: i=1; AJvYcCWabkICOwNAElo0KEjR8DnzjrlDBbHwnZjoSGUJjHkFbZ4lwoOlCoAh5rSvYHHtClLYXj/Gb2p60FUE2Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8lN5rQYInArQplRQi+lksUw3rHAv3TBY8pYIEV/G80+5IVZjL
	vO2ZNQ/0GnpMRkl+oAYoldCRjM7XrxcEIunBFlx8SsypI74nfj6apjbbHDJ4fAQP6sBdtzkmEM6
	d3ihdJmP9ECVzsz75TnVNdbQD5CPYdaDLEW0hCg==
X-Gm-Gg: ASbGncvJmqbCrKdTO44H3WxzeeJ1ptRe0aICsSfBeugK5FXEkbgDO/uMhSbg53v6j5U
	eWuTPgOwp+/GWIQXM021f0u96f3xBgMS29ZwPmZqRHlRTqdU8KdlHa5BVpvHU
X-Google-Smtp-Source: AGHT+IEigGtRgH6c0bO24eOAW8I4NETl5V69OdQiH9GHJHx77IaItBkztB2ZG7by98VApqUzEQYHOlibvmUD+tM8VDU=
X-Received: by 2002:a17:906:2182:b0:aa5:3b94:78e9 with SMTP id
 a640c23a62f3a-aa5f7de5872mr98972866b.33.1733212968141; Tue, 03 Dec 2024
 00:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com> <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
In-Reply-To: <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
Date: Tue, 3 Dec 2024 09:02:37 +0100
Message-ID: <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=disabled version=4.0.0
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
From: Max Kellermann via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 3, 2024 at 2:42=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
> I think at least this patch resolves a recent regression,
> I guess we'd better to address it first.

Certainly your patch is an improvement, but maybe this just wasn't the
bug I was experiencing.

> As for your reports, I think we might need more information
> about this, since I don't find more clues from the EROFS
> codebase itself.

What kind of information do you need? I posted some high-level
information about my setup here:
https://lore.kernel.org/lkml/CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=3D+cbUBP2tZO-=
kEcyoMA@mail.gmail.com/
What else do you want to know?
This triggers pretty often now - can we improve Suren's patch to
record and dump more information when this happens?

Right now, we don't even know if this is an erofs problem (and if this
ever was). It is just one of several candidates.

Max
