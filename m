Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA03F4A02
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 13:46:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtVp909Gqz2xsR
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 21:46:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ErFYDrf2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ErFYDrf2; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtVp15PgWz2xrQ
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 21:46:48 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 om1-20020a17090b3a8100b0017941c44ce4so18452538pjb.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=XbiPizdLBQyb0FOHpPRz6S0x0JliQWkgzWO3Z3uVasE=;
 b=ErFYDrf2xKREg7xAxhp1la6xbzHdSFHNw1h1rC3R5IkopsVAcFF3XllCeCJWxeRHuR
 ebY/jZDa2qR2HVlgWJ6nX8PxcqhkrP5Wk8oah+NIpOw0IaJzUeshwQDxMyBI3W8KW8cy
 jFfXnhiZRQlIvHx7lb+L2cac/GmFsLjo7JoF4vZEFAQwVzGGPhArK84ilb+YFVG5gkPe
 CyyKATPf1pB1tPk6yxnZHrM7qrHqxWr/G/0A9LJMjoUCd68QwGIQPNyTxmLf/q0wBZ/z
 xv1jtlLvf0zdZ5LPZDinarn6Mh1b9zaL4WN/7FehH4+UE1EAXTcU2YmRJvZWhoInJC7V
 ocUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XbiPizdLBQyb0FOHpPRz6S0x0JliQWkgzWO3Z3uVasE=;
 b=TQavvdjZT5ihV3vcYb6rL1yP8CA17rbIQ16Dm0J2weMyHpK4dom78tB0DT6wKMKYW+
 qaafQ2C60vAGJ0+b/OGECO/c19dUSoB3srK31N2zGnLvXaYuhtTObouaLm6arFkftQm4
 mp494eZ/TZ5pN8v0QVXcSYLyciCS/1HPCrYJOp7fRLDQXUGTfl0GJ7+ZYs3WmwwmeTV4
 KJzFeNNmIFB2+23Rzc3qEJOE2muaEHrJFizKB6fPVcZgv503BLaI8y+o7TZSg3m7kmNp
 5VzPP3axZsArupzcvBNJ/MPr5m4wCAtWVSTs14RleKaBhlhwlxZkFRyjh2CErh5risZs
 l5bA==
X-Gm-Message-State: AOAM532/Q1nvYCxLhy8uT4yJeNQu/tWpmUGIeiwf46Rbggt6/af18PsT
 akDPFBuASlfjpztlGI56xbs=
X-Google-Smtp-Source: ABdhPJxuoflQFu5Aa86wrO38Hpf5rhTCeI/TWZVbDWGs2ISTvVjc0+XfjARujE8JGuwkmR/PAFSsfA==
X-Received: by 2002:a17:902:9b87:b029:12c:c3ed:8a1d with SMTP id
 y7-20020a1709029b87b029012cc3ed8a1dmr27944398plp.7.1629719205605; 
 Mon, 23 Aug 2021 04:46:45 -0700 (PDT)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with UTF8SMTPSA id t15sm13777975pgk.13.2021.08.23.04.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 04:46:44 -0700 (PDT)
Message-ID: <fccfcfec-368a-d8c2-f689-e8815c7991a7@gmail.com>
Date: Mon, 23 Aug 2021 19:46:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/3] fs/erofs: new filesystem
To: Bin Meng <bmeng.cn@gmail.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <CAEUhbmU0Y7+-ZF5KQLi4=kaa06VLcbjs=_n7jdH1hZBgPSC69w@mail.gmail.com>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <CAEUhbmU0Y7+-ZF5KQLi4=kaa06VLcbjs=_n7jdH1hZBgPSC69w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2021/8/23 12:24, Bin Meng 写道:
> On Mon, Aug 23, 2021 at 12:03 AM Huang Jianan <jnhuang95@gmail.com> wrote:
>> From: Huang Jianan <huangjianan@oppo.com>
>>
>> Add erofs filesystem support.
>>
>> The code is adapted from erofs-utils in order to reduce maintenance
>> burden and keep with the latest feature.
>>
>> This patch mainly deals with uncompressed files.
>>
>> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
>  From and SoB should be the same person.
Thanks for pointing this out，I will update soon.
>> ---
>>   fs/Kconfig          |   1 +
>>   fs/Makefile         |   1 +
>>   fs/erofs/Kconfig    |  12 ++
>>   fs/erofs/Makefile   |   7 +
>>   fs/erofs/data.c     | 124 ++++++++++++++
>>   fs/erofs/erofs_fs.h | 384 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/fs.c       | 230 ++++++++++++++++++++++++++
>>   fs/erofs/internal.h | 203 +++++++++++++++++++++++
>>   fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
>>   fs/erofs/super.c    |  65 ++++++++
>>   fs/fs.c             |  22 +++
>>   include/erofs.h     |  19 +++
>>   include/fs.h        |   1 +
>>   13 files changed, 1307 insertions(+)
>>   create mode 100644 fs/erofs/Kconfig
>>   create mode 100644 fs/erofs/Makefile
>>   create mode 100644 fs/erofs/data.c
>>   create mode 100644 fs/erofs/erofs_fs.h
>>   create mode 100644 fs/erofs/fs.c
>>   create mode 100644 fs/erofs/internal.h
>>   create mode 100644 fs/erofs/namei.c
>>   create mode 100644 fs/erofs/super.c
>>   create mode 100644 include/erofs.h
>>
> Regards,
> Bin

