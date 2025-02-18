Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A485FA3A7B4
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 20:35:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yy8r668gxz30Q3
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2025 06:35:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739907316;
	cv=none; b=Vpsoh9juHWqOfm/kHJXkZ51sPq+NsOFKphTOeFXl67X2AftC7pKkv3bOL61CRHxoYpfzwNja9QnxuMFrgh32KvM+e6dMp7joK6ejTHhuClED3GW419hpywH+HoQsqRRYN/VdAa1Ame1NsOp4qHpYWVF7VmHTGp776tjh7Z8Dn4NWMTqFT0rFVsRh4eRyptTTDPT36jYWzr8QSddXc1NLeY1US1/t1SOtiRNVPUaL3wuYaRu265/JR+H0UZXBU03uyjkRnS5OfdGMsLerC1u0+SHvYqHXcYtf2gNKJOUa3XuMMMrC/WWFRRZS/2bcyGYM97AgmLKT1KopamYjCI+Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739907316; c=relaxed/relaxed;
	bh=Z0ifdvDk6vrDaFuFk2JYnt6GDLJYz45OW87Y0I9tlTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oXqoFqE04At5d6aQPjrDL+3nLMmtK76Fhoj1viZn3cDqki+UdmftERGMZ4TIvw1zsRQIZ+r73CkdGVvSDRALcTDXQxyb1S04vyRLR1jHqLDGgP5pM61JSZytyQsz9hGk6eW2TdHqvag+2wXi7QFsABj8qSqbAQEPOdyPkd+XRfcj6xg0KtuR3F9XUr+vDsgsWlgrbd0OrLy5fL/we2bwq6oUFLDgrgUWb3DnA/dgfsVzkbRGaYb5eLNoZjwYU0GwIdM6d4AtRzF4Qp4imZ1vsn3C+05jcxiWRll1Thc7U1ak9MVBPIs1/xT5zSkSG6WHmnFBGKpwV9qUjE70nLb8nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=So27H3W5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=So27H3W5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yy8r34mMRz2ygQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2025 06:35:14 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-220d28c215eso86117345ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739907313; x=1740512113; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0ifdvDk6vrDaFuFk2JYnt6GDLJYz45OW87Y0I9tlTE=;
        b=So27H3W5nnxuNBXEcLnGHbw/cYWa0S50F6V8DEsVrwtpzYaU7VWYiKfjRyB14dp7J6
         Vh2IwnloNesgJnboIEAhH9mAT+WKBNtf61+Ez9L3eaiLIHpq4jE08S7H3Agn7mAZaMCa
         yh/jgKPyXn/EH+71Gon7C+mwvVxpQlJBbofiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907313; x=1740512113;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0ifdvDk6vrDaFuFk2JYnt6GDLJYz45OW87Y0I9tlTE=;
        b=ovPnR7fQbgyXu+wl7fA1pf5b2hQQBgx2Bxz9yHG74VnpAEFB/lw6wBsAk1mRRy9Zy9
         fxFy9Jhh9l2BPrA/ClEDDw6qLSUy7ZZf0kTLMif+X6aX5Rt81QT83LIN/gCEDJK/oRv3
         Vk1Ps+xXRy+BScHk60q3Z2CQPTaJcBW9bqNkWnd7Tv34IK/wPhQNyjF4D/U6EA4pxhVe
         pX8bwdyyUv46nU/6iLBPAS+2L8ol3oA0l3CyJxtc7/g0C30DMa3MyLi3HLz8mGWssoow
         +ReivgKuFhA/d/UKWMa6mg8tT1aftHGNOlon8oQ/22zVvDk/5WLpefd/JvZ2i+Z+z6WG
         HaNg==
X-Gm-Message-State: AOJu0Yx/OALY4QkGPTGXmiVv79CJqElch0FL/hziKK/Gu+9Ws+0WeEj2
	3j23xRo8s2u0SpbKpKLclpEBAs28GQHWfk/hKsdbemIvwc29giiBrLQtSuTfPbH5fMqBZJXDFr2
	8
X-Gm-Gg: ASbGncsEMqpwZD228mcGGXcIBFprvxAqdjLa+Y5wuQDJpiExlhL7zNhtGgwgmUWIgcX
	72JMpgwFXcpjPhE1ko/Rw1mLjCJV96XT8XfRRYgWVRGUwkMkI5XH76VVX5GLpx1/WhOlO3YXrmU
	/Hl4bVN8M46OkKzZzPYqL0fTXWrQtTnjZnJLdIPOKLs2wkLW4UWC1Bodf9iev54o1Gfl4gkxhsS
	LOp3N0LMVwqmYi3mUhBI/6VQeBXKrgr0uf7LntkBKGNYN8OCZezkAZRsPPK3Tug8tNgs8uTPl53
	pb4TkHVtItDW
X-Google-Smtp-Source: AGHT+IH4xZ9AmYZ88du1N27Yt/H1KXVXGq3doo7SDwcVAYyLMGw+0OZEGUFSmMJapCK2Do/Hkj1KuA==
X-Received: by 2002:a17:903:22c7:b0:215:5a53:edee with SMTP id d9443c01a7336-221040136afmr225404755ad.9.1739907312717;
        Tue, 18 Feb 2025 11:35:12 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d52esm91875995ad.121.2025.02.18.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:35:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
References: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] fs/erofs: fix an integer overflow in symlink
 resolution
Message-Id: <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 13:35:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
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
Cc: linux-erofs@lists.ozlabs.org, Jonathan Bar Or <jonathanbaror@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 13 Feb 2025 19:28:47 +0800, Gao Xiang wrote:

> See the original report [1], otherwise len + 1 will be overflowed.
> 
> Note that EROFS archive can record arbitary symlink sizes in principle,
> so we don't assume a short number like 4096.
> 
> [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


