Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 735BF2D2F45
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 17:17:17 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cr5164yfyzDqbX
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 03:17:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::143;
 helo=mail-lf1-x143.google.com; envelope-from=nl6720@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Z+7nyLp1; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cr5104bdDzDqX8
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 03:17:06 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id 23so11330627lfg.10
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KENbUHbG5Po7tH9gN4CVSdbsaqN4Qn0BjJbf0mUTGJA=;
 b=Z+7nyLp1t6CvxaqwamLC3LshS68l5CmkQuczmc13kZr9EAe70r5NNZ6fKOVvFCau8z
 QsskOeeXrK1ugdkX1Fc6pilCKRMxpgzFOc/Jsseab4QFXT5VqEemSnqBc+yM57V+9Zc+
 t13AHios7jGowgUWP7i6Pi64iuMcGDnyCjS2PgTdZ9bVy2SiakPu/yN/hX1OvDPctiNt
 9uU0b1zeRJfa/06RSUqFSe1L74dg8+u3Z0EonrTGshMhE7wblgoqHmNxEk6sQzfuasA/
 uFzN5m/+BI+JbfKuTW7joYMFtBbj72qxygXx+wr6CbyYIesxI2KnaA6R5TJ/pQ8Bv0rK
 hfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KENbUHbG5Po7tH9gN4CVSdbsaqN4Qn0BjJbf0mUTGJA=;
 b=Oq9wcA8nXxmuLsMsJKoEcSb8fFNxYT4w+W1I/NtPdF/VKb+/YdZ3VbkisGdCDlAJlO
 1KnRDLM0I6BmOBk+vJbfyDfh85hO83H3Y2UNHVpRCJkGbSz+uAjY8tbB7t3ltXtBKfz8
 k0rTdCEy+fnU6oaGEBQqtVBYYx4c+fuTXg+AnqXC4o1ZEGophE+g+1BR4VC980ydtgNb
 0TYDSOgtdUTjSkLpGFr+A0ePRXq11eBT8FHVI9xCrSiz4dmtL1hAdVhb8peDBCnx5037
 9d2ogBb/t+EsXmk/RGa+E9B8r9Soht3E9Tpu0VflOrL4FSXJXWq9zizLT5eW655fKLL+
 j0KQ==
X-Gm-Message-State: AOAM530km4hZA9jS26/uwQbEMUw01QoqJk1h9Armb4JYb5PuAPIC3K9e
 MfoUv6G7naOUN637plsnftk=
X-Google-Smtp-Source: ABdhPJxsn761Z5q2MGsFVUR9yfxHMhUTHaWvknWDv9QkafxzUV5YsjtRJTLFzQ2mxJGKAnbWqabYLA==
X-Received: by 2002:a19:434e:: with SMTP id m14mr5526372lfj.73.1607444220662; 
 Tue, 08 Dec 2020 08:17:00 -0800 (PST)
Received: from localhost (balticom-231-46.balticom.lv. [83.99.231.46])
 by smtp.gmail.com with ESMTPSA id t12sm3438641ljk.74.2020.12.08.08.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 08:16:59 -0800 (PST)
From: nl6720 <nl6720@gmail.com>
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: fix multiple definition of `sbi'
Date: Tue, 08 Dec 2020 18:16:57 +0200
Message-ID: <29768659.UDeB2voVRW@walnut>
In-Reply-To: <20201208105741.9614-1-hsiangkao@aol.com>
References: <20201208105741.9614-1-hsiangkao.ref@aol.com>
 <20201208105741.9614-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tuesday, 8 December 2020 12:57:41 EET Gao Xiang wrote:
> As nl6720 reported [1], lib/inode.o (mkfs) and lib/super.o (erofsfuse)
> could be compiled together by some options. Fix it now.
> 
> [1] https://lore.kernel.org/r/10789285.Na0ui7I3VY@walnut
> Reported-by: nl6720 <nl6720@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> Hi nl6720,
> could you verify this patch? Thanks in advance!
> 
> Thanks,
> Gao Xiang

This patch fixes the build issue for me. Thanks!



