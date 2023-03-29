Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F36CD8A8
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 13:43:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pml6g3d7Xz3chQ
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 22:43:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680090187;
	bh=9rtdQyV0q9oVWf7iT9zqh6jDfdmbrVZm1KuGQCRjagw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FdaUFrSGYFzJnScTn3aYTum/8MhD/QBjqcyt6+Jre2DzHpskV7EEIIeOCyOL75UOT
	 mYiF8YFwnPCdzxunrDrFxvOW+DcXUCmZ8Wp+QgL9WAYL43lf+L0NUH4zCXLixjP8J1
	 wceg7gizpiv5kvt7rx6T6cwhblzR91pgpbypN3xZ6Z+fn4X6b8uJOwyNMrbZ6iXiyW
	 ZmTOTf1J36J2xCWL+hEfU8T++7jrKrzmVQ6x7OnekDlaQ6P1y0/I1GuuNdYWlSrH7f
	 B2tP9t2Red9vf+Uqul8jSP0s5t76EegkGqHDADHS4VMCgG+k4mp4dLT37SaAS3ol1I
	 z94dLLlhsKBQQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Se1EbJ5Q;
	dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pml6W4P43z3c8T
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 22:42:57 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so15844486pjt.5
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 04:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rtdQyV0q9oVWf7iT9zqh6jDfdmbrVZm1KuGQCRjagw=;
        b=Q9DCAu8gOE/aC5dqTqcGOMb6/svcXsBOFHQxT9/JTW3RJqrJNXmz6aAn8lEkY5+rzE
         LA+3KAeYRmOfGTtL97yMn3g4BwcTysNhmAID7DXejzKuBIPF7PtPtkUnO/rkWJj4TVlV
         MKgG7atmq1cgujATxG+G6P04roqEe1INart8kyQPR8tjphOG4YM3Dixc98pUT/AsS04t
         SJ96+f6ocxZa2K8umXs3JSNzU9gY18W0y0swZv43tRUtuiFtpcIKvI4caNVgP1ADu9Fx
         IAV5EXy1Z/tLXfOchzlKdg84+4CsGiyt8Kt4xx9Tma2u1UgGWdWl2Mdo9VfxIMXW0nKK
         IysA==
X-Gm-Message-State: AAQBX9eAdK2DYzLc76hbvfDveRIzdEEmORPBVnvPVXNNtQuPp/+vJD9w
	PNa9ioU787Zx3z1ZH3qt6E8IyQ==
X-Google-Smtp-Source: AKy350bTawRigOCFkONs1BjCoXDEMU4q+k6uUeg9qWpwX1yJ/AP30l3jQUkeDQFYYF1rceOFjP5Dqg==
X-Received: by 2002:a17:903:28c8:b0:1a2:19c1:a974 with SMTP id kv8-20020a17090328c800b001a219c1a974mr14861215plb.68.1680090172616;
        Wed, 29 Mar 2023 04:42:52 -0700 (PDT)
Received: from [10.3.144.50] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b0019ab151eb90sm5144283plk.139.2023.03.29.04.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:42:52 -0700 (PDT)
Message-ID: <029453d7-1b2d-3d3c-cd8e-64f5be4420bf@bytedance.com>
Date: Wed, 29 Mar 2023 19:42:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: [PATCH V4 3/5] cachefiles: resend an open request if the read
 request's object is closed
To: David Howells <dhowells@redhat.com>
References: <20230111052515.53941-4-zhujia.zj@bytedance.com>
 <20230111052515.53941-1-zhujia.zj@bytedance.com>
 <132777.1680012744@warthog.procyon.org.uk>
In-Reply-To: <132777.1680012744@warthog.procyon.org.uk>
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/3/28 22:12, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> +	struct cachefiles_object *object =
>> +		((struct cachefiles_ondemand_info *)work)->object;
> 
> container_of().
Thanks, will revise it.
> 
>> +			continue;
>> +		} else if (cachefiles_ondemand_object_is_reopening(object)) {
> 
> The "else" is unnecessary.
Will remove it.
> 
>> +static void ondemand_object_worker(struct work_struct *work)
>> +{
>> +	struct cachefiles_object *object =
>> +		((struct cachefiles_ondemand_info *)work)->object;
>> +
>> +	cachefiles_ondemand_init_object(object);
>> +}
> 
> I can't help but feel there's some missing exclusion/locking.  

It's indeed kind of complicated here since the async operation.
Thus we paid much attention to catching the race scenarios during coding
and reviewing.

Here are several corner case have been considered:

1. Don't repeatedly push the @work of same object into workqueue:
Use <reopening> state to represent this object. Once the object is
set to <reopening> atomicly, which means the work has been pushed to
workqueue. And other concurrent threads will not pick the <reopening>
object to workqueue.

2. Don't repeatedly set <reopening> state for the same object:
Hold the xa_lock during searching reqs and setting it to <reopening>.
Once object is set to <reopening>, the same object will be skipped.

3. etc.

Would you mind providing more hints for this issue?

> This feels like
> it really ought to be driven from the fscache object state machine.

It's a great idea. But the problem is if we add a new state to indicate
this reopening status and use fscache state machine to drive the cookie
to do reopen(), thus reopen() (in fscache module) ought to invoke
cachefiles_ondemand_init_object() (in cachefile module) to require user
daemon to open the backend file.
But it seems that fscache module should not depend on cachefiles module.
> 
