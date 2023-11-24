Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA03B7F6B0B
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 04:51:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jDZibSv/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc1HJ5C4lz3cPj
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 14:51:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jDZibSv/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc1HG20JLz2yN8
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 14:51:06 +1100 (AEDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d08497aa1so896534eaf.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 19:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700797863; x=1701402663; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LqsLnL/Rds0ZGKjm8wGlgwbJyIOWd1AHPa8EZt86zU=;
        b=jDZibSv/mfTnarPzXaCPED1SxChnhw4ossOHnoArJsIYzy+MCpevipfEjJapiE1yRv
         y2RlX/05VMO5kQnDcraKv1nuDIwmkvWstc+sTzxrXdh1mkecMYoIInb0TFXIE81zo4ol
         bo2i2aA4hWSXsC6u+YsKpHF9+l2ztiqv2cg2AD39bIHh8r/r4H/x/nSontL6SeXPuPjq
         L4gkBi4KaW7PtIrnRGzufbeiBpu4J1sb5jbsJJPK+q7dkMvqbeqF0bWrtM4MXQyy6okj
         Kg+t4zDd9GgFHta0tjf7jME5ac12HMSyp1dA899STMvCaoAyqJg+2k5zLz8ZrWM7Y8q1
         kuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700797863; x=1701402663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LqsLnL/Rds0ZGKjm8wGlgwbJyIOWd1AHPa8EZt86zU=;
        b=oJRpjBWqFADWUBLFtQkUrdpDBtF7YXVbV+PeWev4I3lbUMlicerrYR5t9KFXzbFugG
         bRp9M3j1Qg+PJxblL9lssi5DoeTUEzh8F+70iTy2qmMqAjP9xzdkQ2BBTlFv9C6By3nZ
         VqZ1TJHiktLA4382fzOOrQv3xR8GOV3/FV5ANgZfdXG3Fe4pRAQKbtMF9P0229USiDpY
         liP5ckIMvFDRwXkac4ELD2VwVHvARMZm3baDlESZ/qs4HLz2KqeYc+ZK6RKmXlBx6rkc
         U2AgXkACRseO0ivtCVIfmfrTWJmIAU6YI/IicD3w/B47E1NzZbPpgrUT8vf32p/OjNJ8
         A8bw==
X-Gm-Message-State: AOJu0YzNVyQothM0ITnCNJD280hDMuyInGkjT0j5D3wiglaX7PCfZOUN
	5ZBdRNaTNqbNRiraGbD+Le0YAbsO/eI=
X-Google-Smtp-Source: AGHT+IGluLx/Gak75KyAyS9LMlbqmznKXLO+RZ94qSOHoShEqXyMuc8ay1srmIg0t5FkV+ituxEVZQ==
X-Received: by 2002:a05:6358:7206:b0:16b:f555:4c34 with SMTP id h6-20020a056358720600b0016bf5554c34mr1444017rwa.1.1700797862777;
        Thu, 23 Nov 2023 19:51:02 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id q4-20020a631f44000000b005acd5d7e11bsm2078463pgm.35.2023.11.23.19.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:51:02 -0800 (PST)
Date: Fri, 24 Nov 2023 11:50:59 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs-utils: tests: fix build warning in
 test_LZ4_compress_HC_destSize
Message-ID: <20231124115059.00006559.zbestahu@gmail.com>
In-Reply-To: <6b899bdb-23c5-50bf-6ba6-ab9d6261fafe@linux.alibaba.com>
References: <20231124033629.26035-1-zbestahu@gmail.com>
	<6b899bdb-23c5-50bf-6ba6-ab9d6261fafe@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 24 Nov 2023 11:46:53 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On 2023/11/24 11:36, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > badlz4.c:72:58: warning: format ¡®%d¡¯ expects argument of type ¡®int¡¯, but argument 4 has type ¡®long unsigned int¡¯ [-Wformat=]
> >     printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
> >                                                           ~^
> >                                                           %ld
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >   tests/src/badlz4.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/src/badlz4.c b/tests/src/badlz4.c
> > index f2f1f05..2a4a908 100644
> > --- a/tests/src/badlz4.c
> > +++ b/tests/src/badlz4.c
> > @@ -60,17 +60,18 @@ int test_LZ4_compress_HC_destSize(int inlen)
> >   	char buf[1642496];
> >   	int SrcSize = inlen;
> >   	char dst[4116];
> > +	int DstSize = sizeof(dst);
> >   	int compressed;
> >   
> >   	void *ctx = LZ4_createStreamHC();
> >   
> >   	memset(buf, 0, inlen);
> >   	compressed = LZ4_compress_HC_destSize(ctx, buf, dst, &SrcSize,
> > -					      sizeof(dst), 1);
> > +					      DstSize, 1);
> >   	LZ4_freeStreamHC(ctx);
> > -	if (SrcSize <= sizeof(dst)) {
> > +	if (SrcSize <= DstSize) {
> >   		printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
> > -		       inlen, SrcSize, sizeof(dst));  
> 
> Could we just use printf(...., (int)sizeof(dst)); instead?

Then it should be `if (SrcSize <= (int)sizeof(dst))` as well? 

> 
> Thanks,
> Gao Xiang
> 
> > +		       inlen, SrcSize, DstSize);
> >   		return 1;
> >   	}
> >   	printf("test LZ4_compress_HC_destSize(%d) OK\n", inlen);  

