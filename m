Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B389D8AA85A
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 08:20:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0rP9xyR+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VLPdF2bWHz3cCb
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 16:20:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0rP9xyR+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::b29; helo=mail-yb1-xb29.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VLPd76Dlrz3bv3
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Apr 2024 16:19:54 +1000 (AEST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-de46b113a5dso1363328276.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713507589; x=1714112389; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxcWMLZqZeeiaOLmoERukd0GWXw5YM1yneLELcphW4g=;
        b=0rP9xyR+RiKoODKre89OIWhwiYmQXMbbzQ8c56q1Yk3tVI3WvMzQn1UkyNJPuL+nRw
         UzQM+znC1r2u9fsm+QkqVG+U0cd/jOMAcvTAz5SropbnjiKElTquRVtxoultm2zJOq0t
         eTBRmZ2tJ4vN9+w/2rkO8nl62WjlvNeAvxyeoZczBprrdZ1p5LZWThgmFYKUMSFTeYTr
         w+oy1QeQtgl99Fpg/4CKDV08Ato7CqJoULl1MvAFWJ5nM7qRzHfawo47qNHv+MwLfU5/
         ozqAZmXQXz5zXuIv9HIvRgjKjZvYJfaoUMRFQwGzLsm2tbjcCEK37m3BLM5TTaW6f6wH
         g2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713507589; x=1714112389;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxcWMLZqZeeiaOLmoERukd0GWXw5YM1yneLELcphW4g=;
        b=w+FDXpJUkrAZQeB10kuLrPa8KHnqxM3zo20hv5VyQZ8a9lXs6/602c4iDJeGjxTh6r
         oi29Y2NNQvRtz6qUNHgVsthFEtaFuWbhGxtufyM59HM7pS7jPNO5LeOPFvdSirVCGF6Y
         OQ02IzKhaA76J17cDsEZMMoCcY7MqfYuyuKYzWPDrzpr0quRVXa9aInQofYqNlr7ubOJ
         9OiLb5CbTDUVGv3ociiZHSD/3KvxGpLEC/ae3S6GivqyqUW9ikipEMt5RNyuXAR2k7RJ
         tykn+eG+ZzoiOqNOvpmnihNjafTg48v4O0I6TEBoydf2j9xH3VtWnZMtXNIJFggJ5v7S
         +kTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+xWiCk1v9b1wPpHvXx7Dt8nFF+YZxt692pVp5ZSrJ3fXg0Rij1ujGI4j9RhIX4o7623vwBaH7V9BkRwa9tPH8Butc3/yllHdHY4E+
X-Gm-Message-State: AOJu0Yyi/OSjnt8lDDwIhoOVxfdA1XsB68yZ2FqommxkdkBWQfVQXPHp
	XKRIyfN+LeGay3TtAPKY7LiVQr7aAIUiD0dF76AvaKFUmqquM5IaZ4dqOY9k3DbpHDbH80BwYEz
	DQF7N6vUIMmvNLJJtB1ePSnRK2SSvuL/tW/Nbqw4rww89HIK9EL6yEw==
X-Google-Smtp-Source: AGHT+IGioZMlWfYRPDzVFEBfSFEWq8HTN79aMNwZ9Qx6UuMITbJysHYpJBETmXy6GHoeEOV5ADzwEhfIFwu5URpY+Ck=
X-Received: by 2002:a25:d5:0:b0:dcf:bf94:bc30 with SMTP id 204-20020a2500d5000000b00dcfbf94bc30mr1021549yba.34.1713507589210;
 Thu, 18 Apr 2024 23:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240418055231.146591-1-asai@sijam.com> <ZiDNrgdW5nJcJs2H@debian>
In-Reply-To: <ZiDNrgdW5nJcJs2H@debian>
From: Noboru Asai <asai@sijam.com>
Date: Fri, 19 Apr 2024 15:19:38 +0900
Message-ID: <CAFoAo-LMM6Mix9fTQ4CmBtix-SGT6ssy-cTj7xxEAuLz+KCrpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] erofs-utils: determine the [un]compressed data block
 is inline or not early
To: Noboru Asai <asai@sijam.com>, hsiangkao@linux.alibaba.com, zhaoyifan@sjtu.edu.cn, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

Thank you for your kind explanation. I respect your policy.

Please let me know if you change your mind,
since I will maintainance this patch personally.

2024=E5=B9=B44=E6=9C=8818=E6=97=A5(=E6=9C=A8) 16:37 Gao Xiang <xiang@kernel=
.org>:
>
> Hi Noboru,
>
> On Thu, Apr 18, 2024 at 02:52:29PM +0900, Noboru Asai wrote:
> > Introducing erofs_get_inodesize function and erofs_get_lowest_offset fu=
nction,
> > we can determine the [un]compressed data block is inline or not before
> > executing z_erofs_merge_segment function. It enable the following,
> >
> > * skip the redundant write for ztailpacking block.
> > * simplify erofs_prepare_inode_buffer function. (remove handling ENOSPC=
 error)
> >
> > Signed-off-by: Noboru Asai <asai@sijam.com>
>
> I appreciate and thanks for your effort and time.
>
> Yet I tend to avoid assuming if the inline is ok or not before
> prepare_inode_buffer() since it will be free for space allocator
> to decide inline or not at that time.
>
> So personally I still would like to write a final compressed
> index for inline fallback.
>
> I will fix this issue myself later (it should be just a small
> patch to fix this).
>
> Thanks for your effort on this issue again!
>
> Thanks,
> Gao Xiang
>
