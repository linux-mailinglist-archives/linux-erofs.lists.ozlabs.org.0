Return-Path: <linux-erofs+bounces-226-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE04A9A0D2
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 08:05:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjlnS0gT5z3bnL;
	Thu, 24 Apr 2025 16:05:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745474716;
	cv=none; b=WCKkB9sEswFMIgp3hNwFxnXqcJFblUvmflbT1m/Xk9J4q6Fe7X/2ZY6pzmGai8/1ozeuxH3txM5Pg2W4UDAq+S3MPrTxS9106OgOQjVG0n4FieE/eIqtNm0cDgQ3rkATQ06pTXKL7dN2i5QtNUV6GnzHdC3Wx+Fy5LPKJGus5Hacn/9IPWtgVh58isYqHRhPBOurlCxnu6CW6SrgCTl+BV2R8YlbC+LLa5ZwsWXQheYAWSTDlmSP0I/VLx3uVnUC0WdCDIB4Zm3IABgiSBalMG86WmJrGQpqo/+rf8TxJi084xT+sSP3ZJ76jg7d42iXU10uCEXLwJNSuVFGCY7t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745474716; c=relaxed/relaxed;
	bh=FgLcY9UoJi4Lz6XopnViT8Ecbt0JoHdDYBsvaCncXhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBFLyltF1vO15mbLwK+no7YhLqQ9vbBTiIYjryR7ngcDydks1oZN2CgonzZsAuuHUeivA0UUUcWShUmnemNoqXxkWFRDDu8RIMFcrQXgkHeTrsbs4HOm1Dt/aBVEHuoDc+KEoKGixbOVDGJ2IvEFZkZLFCfTdColgJVoO/3aMPDBy69UZ4r0LHbs2xHytgjpbX+BPk3X1d9uD2+zvQhhp87pJRTIMTLTV0dpdUXcaMsyu+ZjuVRw80VwfeIY++oORIKtNekukNWnWHKoxVA6besPJxNiczc4QIx8lcwFn+xx+EyYJrwvL6xzZz/Z1Bt3iAOhFbNgrHReE0co5AEYnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=REMoE7D2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=REMoE7D2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjlnQ0Cx2z3blc
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 16:05:13 +1000 (AEST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so811402a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 23:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745474707; x=1746079507; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgLcY9UoJi4Lz6XopnViT8Ecbt0JoHdDYBsvaCncXhQ=;
        b=REMoE7D2ov7P7ceb5YmTF09aqs+bx7kaUIpTjTXN4UseVWp4ASkH9Bdm1x/BgLc9Tl
         ZoIoTJxMeCWYmbcNh+BpAQjJEbQqiPM4/uzwFD/NYj0oaoWHev9VSZ//RDu4xAExLysp
         iL0ST8I5f6nHPmh1h3CrbtzAzhoFwFDEQvg4GzWH2fQWF1eO4oJe+eFbTiNa3jmilmNZ
         JUT9GqmyW8AxAfOESQR3RgZhFEErnWIML0m1rW3nqZymzQELZtw8Jd+nUpkrowGMiaof
         cTuJde7AOfxn9ypjbi0qx0WNsBQrvF8/x7b9YOXLei9k66VgNHXaYRrSqTX+dDqq2Kbk
         RFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745474707; x=1746079507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgLcY9UoJi4Lz6XopnViT8Ecbt0JoHdDYBsvaCncXhQ=;
        b=qkngP3AxIpZJpQHSK4SewGs5Yfx5vlKG7Tx8JmMi1bt5Vks8CFp6iPIU6XXXyp5k/j
         HQpjmvBynzGnnlgeS0OxYztoltmdOfZD/TTzqxPjxhMDrSra02zko1b6zjersId4kcRj
         PCFPNfB/9/ZtCVF59lWo+nTq+YBTJDs5DYs0VryFrS5/pJUsjbJIIrp5hA8Vbb+GebXy
         LBQOrG80qbwxyOzigvTPXJhiBSvrYHLlF57aJ1jenzcWLIudjyEyo8VPAw7PbkdfmIJc
         /Ik+1PzFnipDMzkKt+oLLRcpGyAeITq5egANkDIsNix/lI671sPmte24byCwksRgjIyV
         DDxg==
X-Gm-Message-State: AOJu0YywyfnM4wxNDf767MI6tMacn7cPjMKUdjGCx4jcLIQySloZS2HN
	dIBkmrvoprRzwp6eXFnQxnNmEzRwKzCxpqHaCeWrIxAH3lCSg9xyYN5oHjN/A23nbUeTJA8bsvH
	CBzTKwUAeuIiHpqdOJVN5GTbKDYonoTwg8Maq
X-Gm-Gg: ASbGncsgS7KHpKKvDdtIoXaRObrm5+on7LiFUZe3oS1bLIIH1F9Doix8ZdJYuZildWW
	zV1wXerY/clJiuiXr5E5N0l5GBLg0ZpwDFCmimk8AJJD2bNOkFJqS4HHVXt3n/aJQ1QQlrOyKNp
	c1OtimJ86AIvcJFAleEeDEfw==
X-Google-Smtp-Source: AGHT+IGY004qp6xO5hpjOrDdxnAVM0lG2ykMQcFg2nQh/uVt+HQBW4bobGq43stu5J/Kmy7rjJ4V4FN8UhJ7Tau1rYc=
X-Received: by 2002:a17:907:6d1e:b0:acb:8492:fe with SMTP id
 a640c23a62f3a-ace5748b945mr131046766b.52.1745474707507; Wed, 23 Apr 2025
 23:05:07 -0700 (PDT)
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
References: <20250423061023.131354-1-dhavale@google.com> <94c702b9-cad5-4727-a7f1-16de1827841e@linux.alibaba.com>
In-Reply-To: <94c702b9-cad5-4727-a7f1-16de1827841e@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Wed, 23 Apr 2025 23:04:55 -0700
X-Gm-Features: ATxdqUGZy1kQsEX662y0kBBC-fBrdY3CPiMMq1EptitRYRNGrcUwldc7K2xvlN0
Message-ID: <CAB=BE-SwcvC0sDXAVoK+C9V8Ags+1VanWY_n1hgg8k+UmKH+0A@mail.gmail.com>
Subject: Re: [PATCH v4] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

> I could fix up this part manually if you don't have strong
> opinion on this.
>

Hi Gao,
I don't have any objection to styling as it is subjective. I am ok
with the fixup.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang
>

