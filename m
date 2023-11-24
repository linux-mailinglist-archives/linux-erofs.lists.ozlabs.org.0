Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACB7F6B8E
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 06:02:46 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=judttHRT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc2sw3HpSz3dDx
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 16:02:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=judttHRT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc2ss6Ryxz2yN8
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 16:02:40 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf897c8de1so10532465ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 21:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700802157; x=1701406957; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiykU13Qp2xhEQMsnlstHfcSti7FBtgvHJmrn6dBqEY=;
        b=judttHRTjmcs46IA5Gdl3Snbn0+Nbr6SEwABW+FZxZKU6ldhM0XjChSlSfo4aMGgd3
         6BJru6p9Mdtp0NsXKwqDGtBzMhwNWOob5SQeuUJFOrMf9bB4EgoQUkuy4dKTqORGF2lV
         Ba10VZTApdm0mRQ/xggXg4h4sUOC5BtjpH8emq42b3Ibb4x+VaccCwNGRWgc38dxvtqa
         nrJ3/TWytTHxZ8O35D4vjyFk/ghVsyinjwMVDA5zjLFOh1Gq4/0fclT4OWyKfmKOvQZN
         ZGkyLD+VbKqROEgarGYPkyoXfst3Pr+UKzeIbbHB+Mk8L6RXqGgWtBkRut9vPtqPAtWS
         Q4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700802157; x=1701406957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiykU13Qp2xhEQMsnlstHfcSti7FBtgvHJmrn6dBqEY=;
        b=oaAOiKjApD9fuyd74O4/oLVA+rrcYMisD0CnfU9a058saPT/nQsD2jeJtYMGozo/lJ
         AoHXIoVXm6NUeV+Ym1THMryT2XxCOYz4YVs5tVc8yPJTmO3lhR6W3iE72s4rGSRVtt+T
         dz3PoxmsGA7n4P/6Z9pfl3wZfjq4YGA8XRLjjwFKF7c0FWoV0GMRhr71ZJy4yMxb5SQ1
         IkyMRB5IR7j/7T8Pl1p3ZAj85SpsbaRk23jQMCRDJ/9l5M6vaVqvmv+/fBU2hEvsMt1t
         iacw+aN95Oi024aK1283iNuyBfxNveB0NqOeOz6uJS7l3WAsF6ToFsX7JAoZzxo3VDEf
         FDJA==
X-Gm-Message-State: AOJu0YxL5QNWU38Uo+KdQjpfHIRWPgNEUnFPETp5Fru3dxqOPTQdU7L6
	AgqB34/+9EwXDCKiuLqQK1c=
X-Google-Smtp-Source: AGHT+IE8qu4JqAHQysnwD3kGoqmhuc6+d00W19WTj05TG8oBozf+ZHwhQvC12t5LXpdbOQcLcB4CpQ==
X-Received: by 2002:a17:902:dac1:b0:1cc:5521:570a with SMTP id q1-20020a170902dac100b001cc5521570amr1712047plx.14.1700802157028;
        Thu, 23 Nov 2023 21:02:37 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001cf719484dfsm2230541plh.98.2023.11.23.21.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 21:02:36 -0800 (PST)
Date: Fri, 24 Nov 2023 13:02:33 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs-utils: tests: fix build warning in
 test_LZ4_compress_HC_destSize
Message-ID: <20231124130233.0000477c.zbestahu@gmail.com>
In-Reply-To: <1e41efb4-d70f-81a4-6dab-1b5652ea7b32@linux.alibaba.com>
References: <20231124033629.26035-1-zbestahu@gmail.com>
	<6b899bdb-23c5-50bf-6ba6-ab9d6261fafe@linux.alibaba.com>
	<20231124115059.00006559.zbestahu@gmail.com>
	<1e41efb4-d70f-81a4-6dab-1b5652ea7b32@linux.alibaba.com>
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

On Fri, 24 Nov 2023 12:00:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/11/24 11:50, Yue Hu wrote:
> > On Fri, 24 Nov 2023 11:46:53 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> Hi Yue,
> >>
> >> On 2023/11/24 11:36, Yue Hu wrote:  
> >>> From: Yue Hu <huyue2@coolpad.com>
> >>>
> >>> badlz4.c:72:58: warning: format ¡®%d¡¯ expects argument of type ¡®int¡¯, but argument 4 has type ¡®long unsigned int¡¯ [-Wformat=]
> >>>      printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
> >>>                                                            ~^
> >>>                                                            %ld
> >>>
> >>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> >>> ---
> >>>    tests/src/badlz4.c | 7 ++++---
> >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tests/src/badlz4.c b/tests/src/badlz4.c
> >>> index f2f1f05..2a4a908 100644
> >>> --- a/tests/src/badlz4.c
> >>> +++ b/tests/src/badlz4.c
> >>> @@ -60,17 +60,18 @@ int test_LZ4_compress_HC_destSize(int inlen)
> >>>    	char buf[1642496];
> >>>    	int SrcSize = inlen;
> >>>    	char dst[4116];
> >>> +	int DstSize = sizeof(dst);
> >>>    	int compressed;
> >>>    
> >>>    	void *ctx = LZ4_createStreamHC();
> >>>    
> >>>    	memset(buf, 0, inlen);
> >>>    	compressed = LZ4_compress_HC_destSize(ctx, buf, dst, &SrcSize,
> >>> -					      sizeof(dst), 1);
> >>> +					      DstSize, 1);
> >>>    	LZ4_freeStreamHC(ctx);
> >>> -	if (SrcSize <= sizeof(dst)) {
> >>> +	if (SrcSize <= DstSize) {
> >>>    		printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
> >>> -		       inlen, SrcSize, sizeof(dst));  
> >>
> >> Could we just use printf(...., (int)sizeof(dst)); instead?  
> > 
> > Then it should be `if (SrcSize <= (int)sizeof(dst))` as well?  
> 
> Why? SrcSize is always > 0 in practice, and sizeof(dst) is always 4116,
> I have no idea why it's needed.  Unless there is some another warning
> we need to resolve.

Okay, let me send v2 later.

> 
> Thanks,
> Gao Xiang
> 
> >   
> >>
> >> Thanks,
> >> Gao Xiang
> >>  
> >>> +		       inlen, SrcSize, DstSize);
> >>>    		return 1;
> >>>    	}
> >>>    	printf("test LZ4_compress_HC_destSize(%d) OK\n", inlen);  

