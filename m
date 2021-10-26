Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A859A43B9BE
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Oct 2021 20:40:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hf0xg41Rzz2yMN
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 05:40:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=USCiPN7a;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::135;
 helo=mail-lf1-x135.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=USCiPN7a; dkim-atps=neutral
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hf0xc5WdNz2x9w
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 05:40:20 +1100 (AEDT)
Received: by mail-lf1-x135.google.com with SMTP id l13so785265lfg.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Oct 2021 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t4Qfz0ips2V1TEHy0p8AyFf5fWvDf7yJQlsVFfPLQ9k=;
 b=USCiPN7aUUpZ06J+5Z9w7XmR4KIK1Vd7c1VgUoUF7peieC4U4qWQBCwG0Erf46Ytcw
 fDOnAn2ye8212IhbufXj8f8BjU7L3QoTCaZA5e0LyTizrsIEM7KVUnPRUYJrPGkkA7gM
 IggK9U96oLRZOqcNGWYxq/RwzD/cT52yXBI0zjXK+FZkqOwAl66uV2nSK+cCYCrh3tvt
 FjBf8s7egoqiVCLBTbEh2EOIs4nwT3q4NCaywiGSr7sY8kRkEsRD7hVT8xjxkm4wmi25
 f4388SGU/UdcHaAqYzJumgkgoGAG/Q+7xOSTi70bhZ0UOAdOUhbCWw7QfupqzDnbgR5F
 9/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4Qfz0ips2V1TEHy0p8AyFf5fWvDf7yJQlsVFfPLQ9k=;
 b=zQvz5xjKVEpj205gbw/rPSd7FdK1NyQEKc/E51yufzU2RYEDcjS0dRbGp/fvWnXOyO
 eiRSrfvLroukrRN8uUPgg36pAaOyQWiyGsteMSzaPOPLewwe61TRfMTxZOBIo5cksxDR
 BhuCbv94jdpqX3/6bM8J0QoqX+9D0pgVa9b34wdqrEV6bU8NJY2X5UHKTbZon+UMbBnd
 wMEwPaSTbbKeDPxO/l672OfS/IIuHMP/Q6NUMk8wNI4z2AMh8byXi61LtsSr5AKJ0dRw
 GymlfNT1yLmyA7yjsdeAtVnUxlx3YaVoKD3IxLj5ACY+7hy6hcj4MDJ1UpLZitOEUiuV
 pQBA==
X-Gm-Message-State: AOAM531H5tHhngwc7vP5NrUBtz6jiPK+3p099TB+FBKLfCvNOYTWfP6v
 OoPnNvYxCmld0u4LpRZNmtjdV7C7mbmN3A0gkXo=
X-Google-Smtp-Source: ABdhPJxddHLHKir4bOYdsXTs2zTQNkqngX2rraJP8O5XoygXX55jL2/yK6HsDXpgaFo7+L8w9lXhRQ9x1HvHgp9wiFM=
X-Received: by 2002:a05:6512:1151:: with SMTP id
 m17mr24069049lfg.99.1635273615533; 
 Tue, 26 Oct 2021 11:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025232436.GB10537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <e48a0fbd-6e33-c75d-7991-ab9b4b755f46@huawei.com>
In-Reply-To: <e48a0fbd-6e33-c75d-7991-ab9b4b755f46@huawei.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 26 Oct 2021 11:40:04 -0700
Message-ID: <CACOAw_wOGjmqjZZF0y2gEaQ2EpSynvGB6NzrpT3dh5aMpNXFaw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: introduce fsck.erofs
To: Guo Xuenan <guoxuenan@huawei.com>
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-erofs@lists.ozlabs.org,
 Wang Qi <mpiglet@outlook.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 26, 2021 at 4:34 AM Guo Xuenan <guoxuenan@huawei.com> wrote:
>
> Hi Daeho,
>
> I agree with Xiang that -C/c options for collecting filesystem
> statistics do repetitive
>
> functional task comparing with dump tool. I think it's better to put it
> in the dump tool.
>
> And i have some further suggestions, In actual use scenairos of erofs on
> mobile phone,
>
> we found some accidental decompression failures. so, in my opinion, it
> is better that
>
> the fsck tool is able to unzip the overall data on disk or some specific
> files.
>
> Thanks.

Hi Guo,

I will move the compression rate calculation feature into the dump
tool as one option after you've done your work.
Plus, I think we can add the unzip feature into dump tool. It's more
like a dump feature. :)

Thanks,
