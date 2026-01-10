Return-Path: <linux-erofs+bounces-1814-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA7D0D92B
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 17:44:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpPc26WJ0z2ySY;
	Sun, 11 Jan 2026 03:44:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768063442;
	cv=none; b=IqNO1jp3xK2R2g1iAkTFHcWV4dIa7kyH6QPE9tVse2icTZzLax9NHV+TCVk70NtKpJeqBPye3JdtqRVJoc9nE3vzCY6IQPqvTef+A94DNCuP/wWFNaS5rPeKnGOTV86HA/YCwcS7ERfPBfn1AS6TrJ5hGX02VyqRgyWkIRfsfS/MfqLp8wTBdGR7r5sicmj9vaosE/ncJMu9CwIjpDtkfyQuV55L6M+pQuifyIS2iDCu42uH8x7KoPcJrKFfNV1PopU9F0hrvvt8C9VNAQg3fwIkp7yhSSkBbk+9l1ZXCL/ZD5eplatIWBeICrxhigHMyZopy2SFXrPQEmmXPQzcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768063442; c=relaxed/relaxed;
	bh=LKCMQn0IfbuKVBhTmf+owvTcRWJQ1FOXFFxtz68ro+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtNTE2282QhoA420u5eTIyaxf6YvisKffQ0PmgdTtmmFUWnSpMQXvpe3RdQb0eywPCoN0tJHwe4Kyv50U42MQSMmFVPFj4RK2OnZA4ZeISUTgt7t8p5jfLw+q0jtTA5cHRTmbLewAIF4T2BBOBLq9HTDP7vCLBZvNonQQiAgeDvNPduf9E7iJYrA0KKqxTWpxYv8zINzZHtgczNUIaPizmw1orZevB+Txh5mUITDaMfDi4YoEEET9i+8KWdO07QdXqPCKDVKVt1hqvKJJptdXKxHaYSGhwTjW3Ut4EJGS0xsVMsgmDyJuET2jw7xb/o9z7OSFPDJTBUTtb0FEzxTMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gvcG/9gL; dkim-atps=neutral; spf=pass (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gvcG/9gL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpPby08T1z2ySV
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Jan 2026 03:43:57 +1100 (AEDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6503b561daeso8040790a12.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768063375; x=1768668175; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LKCMQn0IfbuKVBhTmf+owvTcRWJQ1FOXFFxtz68ro+Q=;
        b=gvcG/9gLotuRs3VZK4NvK3vDSMS9+jiVR/CdsNJvNsudjg8fzVpu1MaaDPm9uMlLhI
         jmj7twqKUQZTsIaooMmN+X2m5dMbjOwe39GyHLn/58WKde+/W39C0CoNMIvJ2nGneSp3
         aNr+XBhVxFCPFV+7S1GwCCpolQkcW25oial88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768063375; x=1768668175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKCMQn0IfbuKVBhTmf+owvTcRWJQ1FOXFFxtz68ro+Q=;
        b=dZHcd4XxdO75oWye2NO9qHuR4tB1CZfsNd0RIRj2ItRtXhkW6//zGMux2WKPI2+PT+
         tmnIpabHjrDKfmaupGdFVz+DnuHwpePakY3tzT1RBDWVD9S24VcbiboM/O1er66m+NES
         WCdQiDM1XNBpK9Vkyn6IHdOluS3mNHO0UCBwHDfGkM5WG51IG7tqzNYOfpmwlxCrd1BI
         tu2cUrfblJkSM771zHvSl4eKRnAyBevu2KLkOAVeHV+D+6oWPxvEd7ohMlSUJUVL57AM
         S9rM0Vh9vLwhXFNna7/hfluehM4u2rAvZMMRNAwqiFU639kA8J7xKvJjKFl+woLgALGu
         a46A==
X-Gm-Message-State: AOJu0YzoSb7QYxrDwmmZNsY1A4WhvdqLp+6iB2nIXfFfZc7e52TJAIaw
	prQuTuLdttE6w1UVNo9ew64AVOazg8tgYSKZmFSHYp3kTMGUnnrTzKYG2Stx/OqP3fvNZE/SRTG
	6iibwy7E=
X-Gm-Gg: AY/fxX6koRzmaGWMZPnMdosAk2JDAARdJ49ohzTJ9IP/FtqX8aEgkUu1ppMLGu61pKQ
	cgD0Bw/XW7H61H1X9WyQs7l6mzwhtENDrJtDMLYTFjg//oeblLTFRM62jsGw994N7yKNTCS1w3g
	NdABFoGIh0UKHH6Xfa4/uPQ/FYFTUrHIflTYC8j4BF0insIssTmZ0E9QVvAYLgA+wxZzj3SGTJ5
	Ximc8loPrXtuoBV9e/s8qw1FX9eib1MSZ3tKczJ909PSmAd2ec48E5XEIVP1C0SYjtAUykgeo3R
	OrckK0q522CQT0G2fhVqVkm3KG1zVzkgXmMZzSf27SwXw+e5wDpz0wXds2RoCkb7Wq46dmVlpP9
	ZTKKGC15KAnX8SFm8RXQEpvM7WwDhNqxgi7lFL2Ra4nAcEE7B4+pYeYXUu+xZoF2yERDn9dB98o
	PnjFmpbhkO4Yyuh67KsFur5RlNKGZucICl7hEejAQpUWWfgPse9UGCX3hFkq6Y
X-Google-Smtp-Source: AGHT+IFmF+kYL7m+RFWnBtsQpf/axQE1BGVQ8RXkC20yRgyoi79XLePw+pM+y+IwPK49Z2qhLZYtKQ==
X-Received: by 2002:a17:907:74e:b0:b83:f75d:ba2b with SMTP id a640c23a62f3a-b8444f4ab55mr1276382166b.32.1768063374633;
        Sat, 10 Jan 2026 08:42:54 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f9a9103bsm153777866b.30.2026.01.10.08.42.53
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 08:42:53 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so8239315a12.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 08:42:53 -0800 (PST)
X-Received: by 2002:a17:907:da9:b0:b71:ea7c:e4ff with SMTP id
 a640c23a62f3a-b8444c40038mr1190288666b.6.1768063372839; Sat, 10 Jan 2026
 08:42:52 -0800 (PST)
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
References: <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com>
 <20260110114703.3461706-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260110114703.3461706-1-hsiangkao@linux.alibaba.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Jan 2026 06:42:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj0cUvcmpdm=xHTMXuBRTciD=Ytckg5cO2gT1SkZfVWFQ@mail.gmail.com>
X-Gm-Features: AZwV_QiopZelbiYXHdNJSLF2zVVUib1FYJ0jMMQlTw9c2KOyuZQV87YE-Kh4HlU
Message-ID: <CAHk-=wj0cUvcmpdm=xHTMXuBRTciD=Ytckg5cO2gT1SkZfVWFQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix file-backed mounts no longer working on EROFS partitions
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>, Dusty Mabe <dusty@dustymabe.com>, 
	Chao Yu <chao@kernel.org>, Sheng Yong <shengyong1@xiaomi.com>, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, 10 Jan 2026 at 01:47, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> But sadly I screwed it up again by upstreaming the outdated [PATCH v3]
> and I should be blamed.

No need to be quite that harsh on yourself. Mistakes happen, and this
one was fixed very quickly.

Patch applied. Thanks,

            Linus

