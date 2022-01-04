Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AC484B3C
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 00:38:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JT8F03RYgz2y7Q
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 10:38:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1641339492;
	bh=kuIsiW9qeD3VKnpKooFN1pUiik+NL1kGoZT63SARH4E=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=m6eS5EP9pWCapdA0XYTJOkFi2tAIczbAzySjuXTl1BIxv1OO7OdO4Rt81XYIkqXOm
	 zvOuxwZct1J6mGpzyEjTXFg6eclQkqkNrfx/RTvDKalOKS82r0SBvyr4KimxO2l2G3
	 QGYyjVt93H7ILqOOjWRRfpkv58ABqM4DtLMSXOPpFBfHQOWCZISMLOKz6/xo/OzyQA
	 YMaq8DP+QqTV9HhyU0Ga3xLzXEcxz0YL5C9GfyzKUzM29UCrbDf3eEoFOPYPBiwgLF
	 vrpcvBquGIIpy9TDNgeOnbQocCcGpDCXJeZs6E1svagrVgYF0uRU13e9tZV4KvJv0F
	 tyhprajmJJUdA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::f2e;
 helo=mail-qv1-xf2e.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=gVK63L1G; dkim-atps=neutral
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JT8Dw4H8Zz2xBJ
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 10:38:06 +1100 (AEDT)
Received: by mail-qv1-xf2e.google.com with SMTP id r6so35814641qvr.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 04 Jan 2022 15:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kuIsiW9qeD3VKnpKooFN1pUiik+NL1kGoZT63SARH4E=;
 b=XAmx47x7WS9GmPxnU5aK2KG9iRkoe77plShcw1TiJAl6rrdLR+y4ynqOUdhNgIYMpJ
 E4AVdMf/fqH7m8puelWcb3b7rit36qlVVQ+gG8TFsqWYQzaGgDpoRMUrPG+9M6b1hj5k
 ewrLlMiiUczdLby3/S/uHZ+cFxkRlauYIUIwcamdsBAvB5rmSJIB9jQch/Xfo9JgBVHq
 eOY6WwpdeHrsZptIuw9bwPRYt37QjpejHvrgco7dZCosTJzF6AaYete22suBYP8kwPiZ
 6vTUkYyUSinqW8/sOBCK68Ztp3vyTe7FPYOqyQsUn7gRiBmfZ9K8gs296RAS5g5MQ0eO
 ABVw==
X-Gm-Message-State: AOAM5320jaFR8zjn9nRZuDUk9/eVRhovOO5HpQj7ml2pJ/YxkeaEnAW/
 /nd/0YvRHSDvYnIEINjlQPRk5mxE5h5/yHD4G8dNolx20K0=
X-Google-Smtp-Source: ABdhPJzSRsSC5dDKydRUHnkqBOhwRX1h/kH4+rOPwhjDODmOk5AjOemHA1OvpVRIWtRlLBm3BgxCJZKcFQM1vynLbE8=
X-Received: by 2002:a05:6214:27cf:: with SMTP id
 ge15mr47795854qvb.123.1641339482528; 
 Tue, 04 Jan 2022 15:38:02 -0800 (PST)
MIME-Version: 1.0
References: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
 <20211222014917.265476-1-zhangkelvin@google.com>
In-Reply-To: <20211222014917.265476-1-zhangkelvin@google.com>
Date: Tue, 4 Jan 2022 15:37:51 -0800
Message-ID: <CAOSmRzgOB-78BSc4Ug-xNnS+Cc6x8AZ8zEVTYPU4iiKcOowVWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] erofs-utils: lib: Add some comments about
 const-ness around iterate API
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

friendly ping

On Tue, Dec 21, 2021 at 5:49 PM Kelvin Zhang <zhangkelvin@google.com> wrote:
>
> The new iterate dir API has non-trivial const correctness requirements.
> Document them in comment.
>
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/dir.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/erofs/dir.h b/include/erofs/dir.h
> index 77656ca..59bd40d 100644
> --- a/include/erofs/dir.h
> +++ b/include/erofs/dir.h
> @@ -39,6 +39,14 @@ typedef int (*erofs_readdir_cb)(struct erofs_dir_context *);
>   * the callback context. |de_namelen| is the exact dirent name length.
>   */
>  struct erofs_dir_context {
> +       /* During execution of |erofs_iterate_dir|, the function needs
> +        * to read the values inside |erofs_inode* dir|. So it is important
> +        * that the callback function does not modify stuct pointed by
> +        * |dir|. It is OK to repoint |dir| to other objects.
> +        * Unfortunately, it's not possible to enforce this restriction
> +        * with const keyword, as |erofs_iterate_dir| needs to modify
> +        * struct pointed by |dir|.
> +        */
>         struct erofs_inode *dir;
>         erofs_readdir_cb cb;
>         erofs_nid_t pnid;               /* optional */
> --
> 2.34.1.448.ga2b2bfdf31-goog
>


-- 
Sincerely,

Kelvin Zhang
