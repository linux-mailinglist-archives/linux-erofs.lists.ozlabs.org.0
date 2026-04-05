Return-Path: <linux-erofs+bounces-3204-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g9SqOKT/0WlHSQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3204-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 08:22:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A639D7EB
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 08:22:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpMnX4Q7qz2ybQ;
	Sun, 05 Apr 2026 16:22:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775370144;
	cv=none; b=lKTsUZXYj1CQnixAcOrL6qXRb5ANOspl2+JyCqUvJrd9bezpj4yWOZkkV+2zMK4P8BLFnf6r0yLP3sFJXwUbTYdzwHRy2TCZzWRg9eJrupzQE/JO9TG7Qn2cJAnsYoTreAeI8k5Dl5QEmZboywvGlYtb8CfidR3WqOMzBMhW0uT3wW33f48ZE28TrEpvaGU/mBLqJEPTyfwTKdm70sllm0MUaBpppcf/+ZsD7of9ovcrmtY+VL/ezyaHP6bkdLBXrg4Kp/GEe9hBBHoaxVxHcVz8g4eSZzNezNKhsb+uaBaCkGvoFSDBhgcfJclpXeN5PcEBAPsc750gvtiEdgLFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775370144; c=relaxed/relaxed;
	bh=tUI6GFAn3blqgJOGUCI6Jtm57aqDu1RvX9Rwoulm0rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhFfOGH04uXYum9X/KBLStUCY/o7bHrlldYuwmtOVXYF5LTYg0XaQREPHAjG6e2iY9ylLNHwjMBf6I1XH1bqQM8KMZxUB8O9JwFZiTGLho/bRlSnpYWTczWiwXT6PvMlDSVq0uINX+78scmk5MmvxVocdzBkjR13+b+gkc7plQYrSQxzmUGPancIneWuFouYapGiuP8hjgOJ0KXkUPDF0tc24MGfZLCTlFqwGajjWviQ3w7BiUoZfKJ8KNE8dacC0iv4gWLhQ9TrvTG9WYGM9AR1NV922+1Jgpma9XQ+OM0fRTcdE9DMMWA0AtYxdV+bCixCXWTtQ78dOYmSXnSoaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TfKgb6Kf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TfKgb6Kf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpMnV0ckmz2xSB
	for <linux-erofs@lists.ozlabs.org>; Sun, 05 Apr 2026 16:22:21 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so1301869b3a.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775370138; x=1775974938; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUI6GFAn3blqgJOGUCI6Jtm57aqDu1RvX9Rwoulm0rM=;
        b=TfKgb6KfQKJRH3sszsDbbC1JN4qvC40SOoM2ocEqg/GiFJaxY4Ik17zjT0sb9XZF+8
         61z55zXnmpgSeyUi+0e3EnLZjbNvA5zgW64mMl3LIshzD5n4D/1OKzSkTfOOATeP0Kb7
         Bc/vo0O+062Uf/AU6w8db41POpe+6VAEV2W3jt5zhBAsD9O04gdxNMp390o5l2OrgPP0
         2s7wa5WSK/SWqxZlGRikW/J2KEvj3+CGs/OMZZCz134KJyKrHI/j6FHd1c/r/6nihUZY
         8bp16k/sZErdDEq3s+8TJpyfBtqzH8h1Uznm1+qAW60X+MpLXdX+9IUX+SxF57Y27b8N
         6/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775370138; x=1775974938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUI6GFAn3blqgJOGUCI6Jtm57aqDu1RvX9Rwoulm0rM=;
        b=VS8nuook1vIKld+vwgZoKOTe2O2GPhaC7NIa3hY2FdTYns0Buhxv4yRxQOSg8OIodX
         Od43bFxA5st8xmiolLVxDz0Xa+vuzGsc/58D8Bcf07Ofrj3PDH0i1eC01i3GjyRDm80G
         AF+Bl3oUclMEHnhjXQ7Zzsa1KN0IlZuGdJ4rnOSIWiGcuiiD9HFqzkX7Y9c+EcFcroc4
         Fg3X+xCB8UMyRcFpckm5R/MfjXWi1e0ialIQN74LDVs8xtVgcsGI/TpF5Qm7vO/dLsUI
         EcOaXVBuQAYETAn+S3F5CopLG16iVWiIIfnx+Y1W5FOetEZgm64D+57lBjocnfenLG8N
         4VfA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcHa30Ja/663HHOGOhy6XguMETpXOt3Vo2WQWrKpdq0fKKkm8kE5ABq/odL9y/eCf0IMgGZ0UyJccWg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywzg1ShB1V0pQ9l3YOm9b0FjgA3qoMwrr4igemHpBPscEcMPvYy
	ClaceobancfdHo8DnIwVgVhHp3icTBEqwp+AjQYEUTB719gUNGb2/0rz
X-Gm-Gg: AeBDietug/pJwxrwBTlz64DZ3RLQ8CoU0Uq735+c7xW1yq/K/nr490owdWT3vVsDal2
	eXTsVMQJ9IPH/ZTxtsPtoS/sFXeqDNhat8NJa9GcQ9kC5s5cRIjfIYQVBZizzi/0fkZs8hKDJHs
	hWRYBW7PVQtogpzzwJZTOAyJZ7Pp3frod8o5WDKmXPJNakNePL1/B84YouhOY1/6KBDBmyXlVEw
	FiNhY9yPM2TiSHY9lq1eCToQ49pWqr9m6c3YQKO8POBQNYIiBI+hhjHWRqfah46M/OZKIR6/dgt
	y8eiwncXvBm4+wUylua7tI7LbiQZz86XhgFP5NH/1fSqz/gvc9JH9E/+TZa6mwPs1TbMaI5jcoS
	KW+w/OIohWVHWX8aMgGqxCFBndSWDdp5h0H+UCxPfevMT62HDi1X1zXwEGlyGvy5h0yTyE9fK79
	xQSGt49rGXi+wYEomy+L2siVN4guFX8Uddz6hC4tBJFSWuPFwByO/IPd4PmdhIdddQy3J6WvA54
	6QX7DyrdvuYezyWbghT+BDv06HYPwJLy9Y=
X-Received: by 2002:a05:6a00:428c:b0:81f:3bcb:af2a with SMTP id d2e1a72fcca58-82d0db4fdd7mr7792971b3a.26.1775370137674;
        Sat, 04 Apr 2026 23:22:17 -0700 (PDT)
Received: from ?IPV6:2408:820c:b630:5564:587d:e630:6d6f:b8e5? ([2408:820c:b630:5564:587d:e630:6d6f:b8e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm12695210b3a.58.2026.04.04.23.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 23:22:17 -0700 (PDT)
Message-ID: <8fabfead-c7e4-4dfc-b6d5-20043866afcb@gmail.com>
Date: Sun, 5 Apr 2026 14:22:14 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: s3: fix memory leak in
 s3erofs_create_object_iterator
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, xiang@kernel.org
References: <20260404082737.87032-1-nithurshen.dev@gmail.com>
Content-Language: en-US
From: Yifan Zhao <stopire@gmail.com>
In-Reply-To: <20260404082737.87032-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3204-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 593A639D7EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/4/2026 4:27 PM, Nithurshen wrote:
> In s3erofs_create_object_iterator(), if the parsed prefix length
> exceeds S3EROFS_PATH_MAX, the function aborts and returns an
> -EINVAL error pointer. However, the 'iter' structure was already
> allocated via calloc() and left unfreed, causing a memory leak.
>
> This commit adds the missing free(iter) call in the error path to
> prevent leaking memory when excessively long S3 bucket paths are
> provided.
>
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>   lib/remotes/s3.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index 768232a..94b4ffb 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -911,8 +911,10 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
>   		iter->bucket = NULL;
>   		iter->prefix = strdup(path + 1);
>   	} else {
> -		if (++prefix - path > S3EROFS_PATH_MAX)
> +		if (++prefix - path > S3EROFS_PATH_MAX){

missing a space before the brace, otherwise LGTM.

Reviewed-by: Yifan Zhao <stopire@gmail.com>

> +			free(iter);
>   			return ERR_PTR(-EINVAL);
> +		}
>   		iter->bucket = strndup(path, prefix - path);
>   		iter->prefix = strdup(prefix);
>   	}

