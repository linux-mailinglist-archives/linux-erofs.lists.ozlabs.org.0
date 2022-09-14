Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA45B7F3B
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 05:16:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MS57x3BNYz3bSS
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 13:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Vv9q+dPE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Vv9q+dPE;
	dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MS57s48CWz2xdQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 13:15:50 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id fv3so13226652pjb.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 20:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Hn4otagjumTw49USqUIv3aIESk39vSQ7nnrygHJA1RM=;
        b=Vv9q+dPE9Xt5hHPzis7fhX6kTsf1B9KGILvS9Ojq8U83fKBRmcuLAytyV2QPlwV4tm
         MxpCRzVvZOssnaXJZTjzUkqHQH6yPnaveU6FhJbYJm6NpNT3QwkJVx7cf8FMhTkZA5Dm
         nhXfarzfZC6Znu6jC8Q0FDXbCGV4vUa/bhcRXTIm4dskUe1cyzsInw23LNouaKzJuk5q
         tDzVCXjJkHoH1GgOKoRX7sPPHBjxq9j8JkBXCp3N6Dh54w4qgoGEYFB4TNxUh/I8wC4x
         cL3LeOT+MZ6xG7drZQmcK+eWC/ZVnbCSJX/C5Nje3JACRZB4GOGqC4K69NyWKizP0/Rq
         OleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Hn4otagjumTw49USqUIv3aIESk39vSQ7nnrygHJA1RM=;
        b=CHwwAkE8GcMZJl3hCk/8kRM8H7Os3vv2oCLqLidf9qTTZUByse22zoJ/HjCNsMrCth
         1osYaagYLSrJmOGUMsXfWNXyMie7+Lp+mvAJ/HqhnsWQGH5x4Q1NKECUnniNNrWMBB8x
         S+ifrR0CB2OXl6be8TxP+CP8Ij1HxS9pkvBNtut9fiGvINqy59Saejc5JlytEEHhD66D
         EQwG5Df/s7qCo8Sqvgg5jQOvqMn4wboGj94fDnmIIkuWUQC5+MQ/J6GSNmgkvNr8BD7P
         BDxtgjbu/wTnTIDsmrRWsv5rr05bCef/FvcYUYeGU+TMja8aVM2H2vDYIKoL9BEuX8Ki
         PL0g==
X-Gm-Message-State: ACrzQf1e++IPoGME0IZ3qKE25+LE/Kp/FnC9Z1DW5RZUbom++u/RZ/yP
	cokjDab4GTfrkz1Ywag1upUJDw==
X-Google-Smtp-Source: AA6agR4iw+NO6u+3snYgXRblqsQGkidXfNUi9Nmx0V/cbz6vyRNOEyx0KNTnzX+8/hoiCWT8wAx52w==
X-Received: by 2002:a17:90b:314b:b0:203:41c:2dbb with SMTP id ip11-20020a17090b314b00b00203041c2dbbmr2496401pjb.18.1663125347919;
        Tue, 13 Sep 2022 20:15:47 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:427:1cff:3226:873b:1ccd? ([2400:8800:1f02:83:4000::9])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090a5b1600b001fd77933fb3sm8133364pji.17.2022.09.13.20.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 20:15:47 -0700 (PDT)
Message-ID: <5f8b9a15-ec53-127b-63c3-b32005b35e05@bytedance.com>
Date: Wed, 14 Sep 2022 11:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 2/5] erofs: introduce fscache-based
 domain
To: JeffleXu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-3-zhujia.zj@bytedance.com>
 <56b0a8c1-94ce-3219-6b43-d91d2e0e85b5@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <56b0a8c1-94ce-3219-6b43-d91d2e0e85b5@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/9/14 11:02, JeffleXu 写道:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
> 
>>   int erofs_fscache_register_cookie(struct super_block *sb,
>>   				  struct erofs_fscache **fscache,
>>   				  char *name, bool need_inode)
>> @@ -495,7 +581,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>>   	char *name;
>>   	int ret = 0;
>>   
>> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
>> +	name = kasprintf(GFP_KERNEL, "erofs,%s",
>> +			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
>>   	if (!name)
>>   		return -ENOMEM;
>>   
> 
> What if domain_id and fsid has the same value?
> 
> How about the format "erofs,<domain_id>,<fsid>"? While in the
> non-share-domain mode, is the format like "erofs,,<fsid>" or the default
> "erofs,<fsid>"?
> 
Thanks for pointing this out. I'll revise it.
> 
