Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB759372C9
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 05:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721359886;
	bh=7CKySdNpmm0BXzz/l3fh9LPi1gb26r12rao560Odxrw=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=n7alMIaoqtvK0ymdn6al3jD0UA+LpOjRnyRePhMMvtgjxxIBAPZVkrjF4fzX4mj53
	 wIHBRyc58zf553hZGp3fhf+mM2atJ6GO6KZO62zz0jRKjnRC1Sb8CD96FbJV0bo8ut
	 mHJlJDEf0x0HnfhsSZjP8USGXCC7RpL3V5y8/Wq7j0p9LXWMLfVHoEckbdcG9XXdXn
	 RBkSJxtMA8VZG07komRGozxw3byXzV7HHbxKwgeBqKTnTfpaC1Lw7nTWwNz12QRMFR
	 ktvM11ZK3FNB0jYhIaN5QBNfdctcIPZTFwA2jier+8apfdRkDkES8sFKdHcLQlsR6E
	 qGoiPxVbzp03Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQFZk6fS6z3dRr
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 13:31:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=EGVE0Yuy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQFZd705lz3cDd
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jul 2024 13:31:20 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-368663d7f80so292448f8f.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 20:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359875; x=1721964675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CKySdNpmm0BXzz/l3fh9LPi1gb26r12rao560Odxrw=;
        b=NQbfX97oknVintjFBM42DwIXRId9zZ41VHPpjtR6RHeU4fkeCAbBnGWNaU/wXq19nY
         QgUfWib2IJIdl+1Oyc2awgj6Ik1a0c0TOf362T2+IAnUyd7EMEcJ8Nik9zuqK5gCFf8i
         XsdJLya2ldg9MIhVA+LhhcKyvIoBWyIxamR/yzxZHobwDbaY9Q9p6oTdI+HBTTPrWO8J
         KCnjbhBTyz5DLerXbt37cWogvB2UV9wzJguknXIolbIiYd9+iNSTc42udxPEbzZAKiQS
         /Wxy+cUQRqFaD0Pqp4LOmJToL95cnx4kT0s1ZCMb25xzPivpSwArYNoGABUhlhaHwTTX
         5+Gw==
X-Gm-Message-State: AOJu0YzF4fO+hWAFIxNIcUCHOMRaaTwue06xt7fxEzRtZPwrtNmxR9Lq
	GCGHPAbKJU+NF1b3EwMGa6kVtbOIERRRa4tuDbWDECuX9LV8/PBoJBnXnjErjm+3uVu/4aRZ4+e
	6SQcA9J2vWtJpCmy7cHkly6jbXP1Wzj2y1meN76fC2VcS9qjnvXlDKeg=
X-Google-Smtp-Source: AGHT+IGp1ej4oUsmuasnAA1Q6Jhc9iTTa9YqQ3E3p+hTrxZiuX0G1IJThaFktZ7onQFmcyCpBLhiJ6B94YVm3b9mFq8=
X-Received: by 2002:a5d:588f:0:b0:368:785f:b78e with SMTP id
 ffacd0b85a97d-368785fb8e4mr361819f8f.13.1721359875183; Thu, 18 Jul 2024
 20:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240718202204.1224620-1-dhavale@google.com> <9ad02965-11e6-4285-a915-ce6aa779861b@linux.alibaba.com>
In-Reply-To: <9ad02965-11e6-4285-a915-ce6aa779861b@linux.alibaba.com>
Date: Thu, 18 Jul 2024 20:31:03 -0700
Message-ID: <CAB=BE-QsRykaLxb_VCUVxQfGvKs_Rx9X0pV6TPKJXbpOKq+PTw@mail.gmail.com>
Subject: Re: [PATCH v1] erofs-utils: misc: Fix potential memory leak in
 realloc failure path
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

> Is it a lint issue?  Although I think currently userspace malloc
> failures is rare, it'd be better to handle them.

Previously I have used scan-build as a static checker. However today,
one of the realloc code blocks, I stumbled upon while going through
code on another performance problem.
Then I just grepped and found another one so I just fixed them in one go.

> I update this as since the variable definition would be better
> at the beginning of a block...

The edit looks better to me, so feel free to update while applying.
As always, thanks for the review.

Thanks,
Sandeep.
