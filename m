Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 31230966F28
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 05:59:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725076744;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ck2dOWz3aupOPh7YNXNDE/pTWaT6huSf1Equzcy9HynX5CHMLNMHrGHua3fvy4JAZ
	 DnY2W6ulbYBIASiY0CPV82Dpb4G9QwvOpdSgXqPBi1/lIW3UXAsM862RJJ6rfDvY0D
	 6t7dH0RYo48Q1kap4vjulrPJReYC4afBtMaWw4QZOA4HDUY6PNcr08bp95wMGTxtr6
	 IIDX1cgdfRwZqZIouteefdGzzGXwg7klNBXGJVvnZGkG36EgfYlm7l4gNchnPlcM4x
	 +j3SNdbBOFSZT/pg+1/bXhSwea9ZuysLPLIU7IpIA3uMQO2r26u9DC82J+baODneEs
	 gDADVxChBvNhQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wwh8m6LRSz30Tw
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 13:59:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725076742;
	cv=none; b=ii8DvaFO05haDGp/Molvswgfv0Z4xVSD4mR62BIPcQ1dlHkZOnUaxItohDP/byKavDWpPDgwZk0qVQdrKoLMfYyqMvKCJsTh4eNzppE4ex0DHpVa+oTOOXgf7adgCE1Vzfp6a6JSyqgpZqLvSfFKNxKxV+u969p+ACT5qnXGIVh0K/SUIqx/LoA4FJH5j3hH8Dh7UR+ATITLrxRSALfWDpYroxVJxRR4WEhvuQn7I7XV97tZ8i1S6LBCemI2eE8EP703bMgeS/z2lYgOduwctNZoU5d12RQPoJmD1d+pS1gRej8F7iLnL5kyznYewB2oF5XvkAXpWdC/pIHGou/scg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725076742; c=relaxed/relaxed;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=i5yKQ3oZnu1sTVCa834QEjNgELOOCaq9IMN+HqL2KYNBerhQcv4n0B19WB8zHaLRrCXWLwPELaOkPY4G3eCDGElum8b4XuRoRl9Ny3vV+XX3WHPbiCJ+U6g428jQ+yx74As99oDfC+SACzM1U4P7qt8wvvP5JP6cvvGd6ym3kDFpuxHT+F2nZWDAkeLrWaG7zDbmf4PyxbLsiqWPbgXSKPQqmqRF5H8aNIEdT9zgInFFZ5BmBYjgo1VSeRdgmc/UxR/G5XXBB7owy9mnFazeoO6MHvGWM4hP3CbVC/USCGVl1dVK68aMTkkiQ3iIgErSp2aoAxnXVB/w02UWlbxuMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=PA+Jx3TT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=PA+Jx3TT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wwh8j2bh4z2yyD
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 13:59:00 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so1737472a12.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 20:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725076737; x=1725681537; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=PA+Jx3TTpyxJN1d9MFy8X1Syyzm2TwseiywFGXBjFaOcDrGEd/fKTNoqv1yEVz4V0R
         qz6XQyPR0DWuTaPHrPbabyxAdd1zV9oByfeCh/qrnUq/bwVX7IZ3nMZGYOeeWLPMdi/B
         mz97MnJhwsfyO1ubFRIgg0Cq1rFI+5O/wuQweqrOxnQ88x412eGVqpeUPNDoqcsuDcQw
         rrfj+4WHEPVLJze+P3dz4pddvLNJ+q04DCLHp8IeDwHz4ugLnXivKlb7dJ6dLPYaTrZW
         GmCtvrJs3eX7tlKO04EEWSjx7m5R8HRxVy1FZAgOpL1eYXrbzYQrAYYVmLZ7mqFBmTA0
         gkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725076737; x=1725681537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=MMehInVVvGye8XvPMgEMxvBzN77PhR0F+tS37XITgLP92blVMMi/dLcogedmNBo//F
         o9yrlu42RDzE+Mdzzs3E1OvYZGebhWmIUKkK+kOVwQ07OpAicRGVQMm4fJjRdlVsdcnp
         2jC6Npp5wL7ta7W2UMsqTljKPs6NokNYp25GDQqamTRq5s5wyYWSkSbWp6rlGOKbU46K
         ZWFUyygS3LUGS5Qw87/+T4u4KhKBAQ2uOuscuHuXQWNPgxWHva0dnfmDyZo2QDD9QOcK
         qSQinh6AKuDq5+UJ3RT6vbeG46HIgfdkS2A+87AQciPnWQIt2Wv+IIJHu5awuG6n8RVN
         jKcw==
X-Gm-Message-State: AOJu0YzVqNcHwBbblnQvF8sGnf7/Wsc0T/CgyoED5XzHSA4XHOH/nIv7
	cZ2Sw82ypEUxiHVZimZlHmHaPbY4SDOSzdYa1ThdSCCmsy2xnsHz7IVebRWQgf1vgA7NjXA0CRv
	1F46/ZN1/9T8uqjCaXxkTujND5gptCZmJ/kmb
X-Google-Smtp-Source: AGHT+IGvSsTxGnmGy52HEs0AWQVc9uOA95moP1WUWdsdF70B8NLWhSpK7F/Ua0LHhPz8pxoeYqSXEy0rCXh1hOLMMHg=
X-Received: by 2002:a17:903:292:b0:202:2e81:27a3 with SMTP id
 d9443c01a7336-2054731dac1mr11309365ad.29.1725076736855; Fri, 30 Aug 2024
 20:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240830065542.94908-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830065542.94908-1-hsiangkao@linux.alibaba.com>
Date: Fri, 30 Aug 2024 20:58:45 -0700
Message-ID: <CAB=BE-SARJFG7x_j6C25ZUPMuSikPU9qJFo+XY1=uL=vkO_Vjg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: don't include <lzma.h> and <zlib.h> in
 external headers
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
