Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581E9F2DE6
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 11:11:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBbMN5kCDz2ywC
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:11:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734343902;
	cv=none; b=QF+VagnTR6qJfTRSFdojsPsKfh4+aAlptNdpU8PBzeOq71cH2csX+uB9iD++/5e5LgpNrdgBO6pcgm0R1hJ5Z+yK9zHkQ3+nBwXgCK5xdzYQ78ND+I9ZiTk6tqqjxH1isLEeU0f/ARe/a2n+67WubgjW3cPx/DEY3V9JMHjUj7Ct9+uGys26tM9yqalDM3NMDkr0VJAgYw6WAGh7NRJ/i9tX6ZbYyk7V+eGcBspeIB4+tcupJP8hXaKSQqrKVFSAUHQkLP2i1vO09AczNGHfBDNfN+/7h2ALRQ7S9nFDwGGuClO+UUYX3vHX6FBbfikNZ7p9M8OIHxWkeG0UMsLNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734343902; c=relaxed/relaxed;
	bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaQOeiCh2B/8B7YGaX9iwJQsPK1/MvpmRpTAG+uM3IoDpC652UmghWURnFjou2vKMHZmDDj/ygys0hlLG9pu+36/CnqJ5VscSdlQhWWMnwdeAArm/M2nGSfRAtuIOekGUM+ZJ/9inZ8MJNf69l29usxRn6HeXRutt4Pnb28UwMUIgp0CEyBXAqeQ/lOJIWUIdN/lJ8DfQU99w+R2xBMZmB/OtOCCwGFnmhdbF713V87aLjAF+o5b8dpQpSEv+jiBWYTlAmu4wHEHtBg+hHzXeDigiIUHn2WubaV2dXgSLz/rmt4znDN1r3i+HmX60X9F1lQ2hxV4pUkmJ8jOMUOgLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bv+WLUzS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=akiyks@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bv+WLUzS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=akiyks@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBbMK4ycxz2xbP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 21:11:40 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-725e71a11f7so3579284b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 02:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734343898; x=1734948698; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
        b=bv+WLUzSiFvW8evdy26Om/moWg882OB/iwyhNKJsTuok/GuU6mi1kBW/OdivsUkafs
         r+ailYFjX5iFod5auaxaQTAGICQOWwIN/VkIo0n3iQIsVGdKdm72jyBnuDQYJg91Wkb/
         kQQlgdd4PO/U4u80+HTseqQIzVrv5JD8eIi6c3UZIX3m6dLz6lJ87YI3FIfqDzNLmQwv
         ayxLaSF6r9QFEHHCaz1jeRs2IXJTfz2NVcA6kfGhxSMPT17frARa52/nvo3QlEYcgTpO
         EYTnfVCcsH/ZRbYLkO4//SZwXhfKC83HsGczKuMkkdebZ3JW2BG1I5zqHe0eJae+Xv4x
         2VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734343898; x=1734948698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
        b=b4Sva13M5vwBMoSgMAfj1i/rR/0h0A/ZGIY2l6TbuRwVh9lQP2Zvosqd+2/g4FL4jL
         F6kocmqOFT10xi7WQiV9LzBYr44pTVsqLpjx2wTgwO1b97+A6+XWO88zQ7u2fclfCKDM
         LEjbcV4a46krogZj5CLOdFGJcZjKVkQODjLg4apRihgWHWjiRprX8fD4WaWQboDPPzWH
         0WWHPSsuAgKNx4JbfeAV1gXL19hYZ4zBnVsPHPMaOiTmgnc96ne7Xb7JDGOcS2khQJAZ
         D6+3Ab53+HH3HvpILcA9uqhE8RuJwCbN1251JDsdXU0ZVIQHWGdpcc0PAtwZGb4R5Zmi
         7mgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+osbx40vsO9oOpp0d7d2GrUqI2OR56V9Gk/tbfkQIydNrd0b2E9oMSx4x1H+6DTBHyf6yvcf8Gn9ZKw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywy/r/F5jeogC7SbjwNgHYQW3/X6nFRsLKsDvyrqKeujON89vVz
	TM3RJ29nQWSUIiwWbJA7DzanJejMFY8QqlBOzXg/39h6A3PZY06n
X-Gm-Gg: ASbGnct/LEBgKffpAZjArFhffS+hWY9q1TuBMs844y+wsdcckP5FNsAVymz5qJydLhl
	qVCrDtXUsJbq/absGYRAx2fGzIe44kTP2pFMlzZOjPisvu7+j+XYVOGtNJw/ThIIhvrK03uNrhT
	mrfupNF5HWyztpNQPJYiuuRATbfMaFuTKdzOK3TF6bp6LO04Hd8xVMf8dKoRz5KoNVRhyAx10ti
	vtx4VeRjr5U6OxYsoQlClSR7ajdSjONceK12wPXMNE6eOMZOm0WOWKoiwZWKF68hjY9yv3iG96n
	Np0fVce6FadK3FWI5nioxa0=
X-Google-Smtp-Source: AGHT+IGkvlAjtALOBMooHfO7cK9L9lvwDBwHCDIhwn8y88sRHLlwLffLXlgmsZ5Mm6dr710N1QQFRg==
X-Received: by 2002:a05:6a20:a11c:b0:1e1:e1c0:1c05 with SMTP id adf61e73a8af0-1e1e1c0202amr16720966637.9.1734343898208;
        Mon, 16 Dec 2024 02:11:38 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3a513sm3824066a12.72.2024.12.16.02.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:11:37 -0800 (PST)
Message-ID: <554ff96b-5be5-46b0-ac8b-f178394856f3@gmail.com>
Date: Mon, 16 Dec 2024 19:11:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using
 clear_and_wake_up_bit()
To: David Howells <dhowells@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>
References: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
 <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-8-dhowells@redhat.com>
 <3332016.1734183881@warthog.procyon.org.uk>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <3332016.1734183881@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>, Christian Brauner <christian@brauner.io>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells wrote:
> [Adding Paul McKenney as he's the expert.]
> 
> Akira Yokosawa <akiyks@gmail.com> wrote:
> 
>> David Howells wrote:
>>> Use clear_and_wake_up_bit() rather than something like:
>>>
>>> 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
>>> 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
>>>
>>> as there needs to be a barrier inserted between which is present in
>>> clear_and_wake_up_bit().
>>
>> If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:
>>
>>     This operation is atomic and provides release barrier semantics.
>>
>> correctly, there already seems to be a barrier which should be
>> good enough.
>>
>> [1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.clear_bit_unlock
>> [2]: include/asm-generic/bitops/instrumented-lock.h
>>
>>>
>>> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
>>> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
>>
>> So I'm not sure this fixes anything.
>>
>> What am I missing?
> 
> We may need two barriers.  You have three things to synchronise:
> 
>  (1) The stuff you did before unlocking.
> 
>  (2) The lock bit.
> 
>  (3) The task state.
> 
> clear_bit_unlock() interposes a release barrier between (1) and (2).
> 
> Neither clear_bit_unlock() nor wake_up_bit(), however, necessarily interpose a
> barrier between (2) and (3).

Got it!

I was confused because I compared kernel-doc comments of clear_bit_unlock()
and clear_and_wake_up_bit() only, without looking at latter's code.

clear_and_wake_up_bit() has this description in its kernel-doc:

 * The designated bit is cleared and any tasks waiting in wait_on_bit()
 * or similar will be woken.  This call has RELEASE semantics so that
 * any changes to memory made before this call are guaranteed to be visible
 * after the corresponding wait_on_bit() completes.

, without any mention of additional full barrier at your (3) above.

It might be worth mentioning it there.

Thoughts?

FWIW,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

>                               I'm not sure it entirely matters, but it seems
> that since we have a function that combines the two, we should probably use
> it - though, granted, it might not actually be a fix.

Looks like it should matter where smp_mb__after_atomic() is stronger than
a plain barrier().

Akira

