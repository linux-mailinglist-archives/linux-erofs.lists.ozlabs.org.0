Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117024A6825
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Feb 2022 23:45:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JpKkt5hnyz3bT3
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Feb 2022 09:45:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1643755510;
	bh=/hwlZR0EXq5qLzzlDV/ssWf9iKbSqoU4s5T4m/SaoSM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SRNeGUTkLpiqCib+wqIaIa5oIxRizLS7dWWWPirdIQg7Vd/raUS/UZGHGGvtoWEMN
	 pELnm8YhV+n//9K2zA8V8+bAMeGBAPU6qnnOeyAReMU8H6uscXN5KhSRh2ZKMnaQho
	 XvjTQdiZ/7w+BODOPpOPQVzz2VrPZzDDgIgK56sggCzbBePjVuvwiR6fGoIZnxzVDY
	 y9yO4fE4+lgGR4C6kAYBl1aNjEaD5z/Q9qh5lqngSJllsF02UE+xNOtGesiOJ4nRh+
	 phVK3+x4jTsnVIdvU7Q+f0RLKUvC0148I8KNHhpiZk95cDoj/Px9Zc8Cc1TRg+xFiV
	 d+0iXBSul4nSg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::736;
 helo=mail-qk1-x736.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Wgbjn/9R; dkim-atps=neutral
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JpKkn0409z2xWx
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Feb 2022 09:45:02 +1100 (AEDT)
Received: by mail-qk1-x736.google.com with SMTP id 13so16536968qkd.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 01 Feb 2022 14:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/hwlZR0EXq5qLzzlDV/ssWf9iKbSqoU4s5T4m/SaoSM=;
 b=RpLlwV0w9qMv4i0Z18+uhmFzvzfvOdLTnlVKYhloRJKG1UVcZzHESU/iUJ74CqeDK0
 4j/PrtPaXuTx9/iXjEE0h/mzlKngT1bvD/UXsxK76aiAOSFdieS60FmNURneh/7QXC1Q
 rVv1JM2TsmXznqNnZoRy7yuBcKpLQsdkDNHx40FTAK7zJmlSBkVTEYYEqYh2wlTq1DEv
 AGO8YnT74bP7ycDEOL69N0QbnJTIMFEnOPyv6Ndh6fPbv+v18tLrR5oOyPkcdHMQdN07
 cvX3H56xorz4w9f8EYmEmFp4dqYNrMAWrLbb0Q7Ecm1h2eu1qP7p6t2zUYtyCqsF2Lm3
 1dxQ==
X-Gm-Message-State: AOAM533/WXf65laqE6FPdz0/Do1xFBnj30lj6S+aJWa9tY07LyvqElb9
 MyGv9fVQYSogl1uLT32COgOzWBS2uc81E4DNqc6GyQ==
X-Google-Smtp-Source: ABdhPJzLbEfneK68pBc4+OQ5WTWDZQSfWbgIiyxA2YJYefgfGwD7KxF83GSK5WJ6eakQPCEMoMDCujugK8ECxCjSkdo=
X-Received: by 2002:a37:a810:: with SMTP id r16mr18838436qke.733.1643755497739; 
 Tue, 01 Feb 2022 14:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20220131184327.30176-1-zhangkelvin@google.com>
 <YfigFlpvjDBbMsYS@B-P7TQMD6M-0146>
In-Reply-To: <YfigFlpvjDBbMsYS@B-P7TQMD6M-0146>
Date: Tue, 1 Feb 2022 14:44:46 -0800
Message-ID: <CAOSmRzjL=ufHBCcyCxHArizdV8cr0mjuER1CBiYKm5G3CzK6wQ@mail.gmail.com>
Subject: Re: [PATCH v1] erofs-utils: don't hard code constants
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks Gao! I'm reading compressed indices code recently. Is there any
notes/sketches/design docs you can share with me regarding that?

Happy Chinese New Year!

On Mon, Jan 31, 2022 at 6:51 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Mon, Jan 31, 2022 at 10:43:27AM -0800, Kelvin Zhang wrote:
> > Use sizeof(z_erofs_vle_decompressed_index) to compute legacy index count
> >
> > Test: th
> > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> > ---
> >  lib/compress.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/compress.c b/lib/compress.c
> > index 98be7a2..c520a1e 100644
> > --- a/lib/compress.c
> > +++ b/lib/compress.c
> > @@ -359,7 +359,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
> >                                                          inode->xattr_isize) +
> >                                 sizeof(struct z_erofs_map_header);
> >       const unsigned int totalidx = (legacymetasize -
> > -                                    Z_EROFS_LEGACY_MAP_HEADER_SIZE) / 8;
> > +                                    Z_EROFS_LEGACY_MAP_HEADER_SIZE) / sizeof(struct z_erofs_vle_decompressed_index);
>
> It would be better to keep 80-char limit rule.
>
> Thanks, applied.
>
> Happy chinese new year!
> Gao Xiang
>
> >       const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
> >       u8 *out, *in;
> >       struct z_erofs_compressindex_vec cv[16];
> > --
> > 2.35.0.rc2.247.g8bbb082509-goog



-- 
Sincerely,

Kelvin Zhang
