Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A82809E23
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Dec 2023 09:31:27 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dABsNF0E;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Smkr80FTYz3cT7
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Dec 2023 19:31:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dABsNF0E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Smkqz2TR2z2yVh
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Dec 2023 19:31:09 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c230c79c0bso1318404a12.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 08 Dec 2023 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702024264; x=1702629064; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VourKPxg2Q+bxGJMsn8XyNDYrDZ0v8oel3XGmBL1f3s=;
        b=dABsNF0EPMSDQHvjq0PzpY0qXXVHp5ONN5EyZmTuKB1EGk9xZ1+RkKlplbGwePb7MQ
         fnP/KbJQB77dIukZbjkWZrFqO4a8MLbiwDI9YJI1mYepo1F/n4M2V8t52/n9RARWa4GT
         r6E8LLNWoc9UZgYhBdGJ+69bu4+NBNuq4oWnAxZpX1ev4y3J+6eWLnzPd6IgS7y34qFr
         h+Q4MGe9wjRzenRwdT8CLAW+oQLOY/cxjwa0cVxUTlzcyiQqdI7fdOEtoXMciwBGhs+K
         PXDEsxFiQ+pKz1syNsfOSUPVVqUMy2mBpudMMoOyl0ngCIgxkYG3h1axxvfJdcPLY68K
         VA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024264; x=1702629064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VourKPxg2Q+bxGJMsn8XyNDYrDZ0v8oel3XGmBL1f3s=;
        b=FbtSH2gMVnGI4ONJH7u28xsICnTs2A97Al78ZROfYHziyeZWR/ocjselMqLVOa4MxW
         X4MQPDZQuSBU5H6Zfr6Gq/LsaFYt4Ago4iHiphTFMuaY6C6A3+MRq8KM4TM/4FqdyyNX
         Ha4nsLvBDR60e+z78rLQm20VAoGRHaT04iQAb2dBfH5vPiwbmVZO6NThPZ6WpZzdDM30
         yANztYPl1//FYupC9osLQNLimBenZeRrDjqv71hW7Hw5docvKERmNHp/uxKm8wAFsHkz
         1yhqOlMX1jpXLMWrn36i79qey5zBJC9lHo3kX1oYPAJc03D5QC7VUNUmWIb2PQkrPUpL
         GE2Q==
X-Gm-Message-State: AOJu0YzsXntc6EN5FM3mHiUIDdvh37pxMiFIxOW2SKjzp62OyKbXEROt
	tGtLKrHRh7ESTgnB9cgRLryDh7BLrJo=
X-Google-Smtp-Source: AGHT+IF1n6V/nOTacXE6nw5HEocHvw9bqJ+ylQdJCMoz10wFi/Q80VgffnCw+4MDtYX4a/ZIb9d6XA==
X-Received: by 2002:a05:6a20:cea7:b0:18b:236d:3f0 with SMTP id if39-20020a056a20cea700b0018b236d03f0mr3085781pzb.43.1702024263874;
        Fri, 08 Dec 2023 00:31:03 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id nk10-20020a17090b194a00b002865781c51dsm2778752pjb.18.2023.12.08.00.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:31:03 -0800 (PST)
Date: Fri, 8 Dec 2023 16:30:59 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for
 sub-page block support
Message-ID: <20231208163059.000053ee.zbestahu@gmail.com>
In-Reply-To: <8bdc5203-2356-4a7a-8f26-39fa4b2e2a46@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
	<20231206091057.87027-5-hsiangkao@linux.alibaba.com>
	<20231208132031.00003b8d.zbestahu@gmail.com>
	<9ced71c9-4460-4907-abb9-21b517a883c7@linux.alibaba.com>
	<8bdc5203-2356-4a7a-8f26-39fa4b2e2a46@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 8 Dec 2023 15:44:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/12/8 15:34, Gao Xiang wrote:
> > 
> >   
> 
> ...
> 
> >> min_t(unsigned int, ,)?
> >>
> >> ../include/linux/minmax.h:21:28: error: comparison of distinct pointer types lacks a cast [-Werror]
> >>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))  
> > 
> > What compiler version are you using? I didn't find any error
> > and
> > https://lore.kernel.org/linux-erofs/202312080122.iCCXzSuE-lkp@intel.com
> > 
> > also didn't report this.  
> 
> Did you test against the latest kernel codebase?

Sorry, it's my testing environment issue, please ignore the noise.

Thanks.

> 
> > 
> > Thanks,
> > Gao Xiang  

