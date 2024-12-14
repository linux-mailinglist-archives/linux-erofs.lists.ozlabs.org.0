Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A59F1E05
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 11:16:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y9MYr45Ktz3bTJ
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 21:16:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734171390;
	cv=none; b=hLZMWSlNII2SfoO2cdgnaQJajFxHmzcLoW6J3o9OXVXjuPhU6oh0gLZqnwrxG5iTmn/Fr6lxzdOwqy6nOA4qehRxBkqySm/LZV/d/7pDvuLH6adMm3xIT9KZjLNBoRSDOdN1gT5jMrARCex//gdyRTgfwlS20N/bsBENkXtgg3GI8Axg23o9ADLeQdz/3kP4I7jWC527GInnpzl2FcrjM9vamjK5N8gIgAxth1C8S3b9gilsGUn8Vjj+/ZkFyTO5FV6pT6KI6msk4UdLrZ/X3nWFR+GDPL0Jrb5bcN+pWIelWvpOvlmfhGGa9dZIs05EgHpAsvhNy3t264quJkiiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734171390; c=relaxed/relaxed;
	bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEaBj/vdX1UsfojdxpmI+5PpejQllTSHqKH9rVSLlg8xfzOpYF6FNK8tnwkKdDBu2M4Zoiy9QtHVkMNpOanamVC/8rI+8HhMPxmXcTXeWKezmKwxnYfREcgO00bmzua3GyStAz3vnZquXpmjG5shonLmQB9W9q0QbZUEW3wxBBz1akjzbRX4N7GcMeUvrUw2R126QdQ+KXJahi2ESuNGfJmyTWneb0O1c/KQik/3jHB2wFTtQildZt6iocyymvAOpg7t21OvlbZFf8WC3qiTawh/zTdas2/mZ2a9FZLDRvYQgtAhv8DYhQfB1AwCC9pb0jGc7diSHf0OnaglJefy/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YRuUpmwy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akiyks@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YRuUpmwy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akiyks@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y9MYm0Sk3z2yNP
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 21:16:26 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-216401de828so21478815ad.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734171382; x=1734776182; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
        b=YRuUpmwyMuUBLAyF0xrBNxF6E58VXa8mmYYMVCYsCVmI+X6bkN6hMVoe/I3rDPSZA8
         IWxFZFbp488hw9PJYsgA5HBGg/uEDFM0zARyAn2aEx42sJCdEPQbYpe9mXOu85vDGEOW
         zAFTVx19iNJb/92MYUXZVhBCkXL7ogYB0K2CMar8FNvDQb9eQ2UjB5e4QEFhdcD+ZYsv
         fPe46EubyW6OsCnte9QKYIqxpVZzy1jnV+6Drw2rBSdqk6BwUJiWPHTV+hLM6AOoqG9f
         EtH5XFVY9sKgO2onHxdWfeK+VRjhC6gZFsG6m+zACKk8GitpBjSeF9JyQr4KNkrmxfh3
         MGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734171382; x=1734776182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC99pq7hRHFrLDw7siiOrZ7FqbwdIbl7gLGxK8elhYI=;
        b=CBJmXXCbgUpo73zjj1BLyLel3Gjc5Xi9YH+qrWv/6aYaj+h7eXQwqCqF7Xcvg2sN/o
         4yOdOtg/jdNUqRIBmHucINZc/pKqqMMeEKC6D6zxZBfrybukftOv4L3LVdOZvCWqc+RP
         3IRzr8L/kRl/sqiyts4VgNVhXIoRtjvzy1FV2J8r3cnBDlABzC1Mjxftmutfa0hYLimr
         xc8xM2mpLTTlbyQdPM+eEchAfBArLyEQvaCqiTEAhx3PDOjgwFNujVx9yMD/dVvsCexh
         1/eC8NMvXO8zSuq6BcUjI0UdLh/SQA7dhSAH/u4HXhFA6/jOzfvqsNf9z4z2egsY6JgF
         6xSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTsgTNHahDMwgOsiK6kH2hpIfuyrpCKW5swBgvT33hTUbkdK6m3mazF3GcyfIFzFlhdyTJpBs6Al/V+Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZ9MiCdBF2omXGML70eqcQXs2xTjAysf1Goy4Dj3IZHzRaJN1J
	MM6BK7XZ8lWOAAz9UOlRC55IUpv02M/mUIReMVdwIPL+eay8rdIa
X-Gm-Gg: ASbGncvwueQylsVu77CmqGjGCLL0AF7iGsrfoqCEt7xvCvKVwy2rKN8wOV92ZU7WUBb
	YgaWgZKqd0exFhIQicXJFFg8crj7oChA/W3Xk5+NoCMREJ1dgMMg/V2GSIwVQ3i1wwJ/PHzyNCj
	x8VwiOBDDlKqptYrCPtegm206cDlH2Jj9cwfCnpgxczCLw18l/IsVrOgp+A48743x9qYZyovSkt
	dlj7LRrLdZCKnkCPfIkkhYGveGKEICp5cT6gh4NEtTirN+2Cjtl4CZ/fqljYGrQR/JbrgQEzN9k
	BU26hkATE23yyIe4NGxFO6M=
X-Google-Smtp-Source: AGHT+IEZVE15/vEAohikUk6vjIGzOeFn+yVnxHcYlw+pZKWRHHAPNEYP1GeDSZ8W1ZJPAeFwPcezZw==
X-Received: by 2002:a17:902:f70b:b0:216:28c4:61c6 with SMTP id d9443c01a7336-218929fb17bmr82919535ad.34.1734171382443;
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50455sm10069475ad.159.2024.12.14.02.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 02:16:22 -0800 (PST)
Message-ID: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
Date: Sat, 14 Dec 2024 19:16:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using
 clear_and_wake_up_bit()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
References: <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-8-dhowells@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241213135013.2964079-8-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

David Howells wrote:
> Use clear_and_wake_up_bit() rather than something like:
> 
> 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
> 
> as there needs to be a barrier inserted between which is present in
> clear_and_wake_up_bit().

If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:

    This operation is atomic and provides release barrier semantics.

correctly, there already seems to be a barrier which should be
good enough.

[1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.clear_bit_unlock
[2]: include/asm-generic/bitops/instrumented-lock.h

> 
> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")

So I'm not sure this fixes anything.

What am I missing?

        Thanks, Akira

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Zilin Guan <zilin@seu.edu.cn>
> cc: Akira Yokosawa <akiyks@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c  | 3 +--
>  fs/netfs/write_collect.c | 9 +++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
[...]

