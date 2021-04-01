Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5D8350D40
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:45:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pxd6X6lz301D
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:45:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFHb1v5t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFHb1v5t;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dFHb1v5t; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFHb1v5t; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pxb26yTz2yxG
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:45:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617248747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjaNSeBgfzgkuyEsWxYZoYBCpAjOIOQn7I8YDCkmDGo=;
 b=dFHb1v5tJNBcDuwHgD30UxS24ns1JuxChuII8XEY/ruQIlyJwSz/9pbrgM2pfhXjAoQXjn
 LibCuizmf5XqI/ZohoHsC2RJYba1YeqDpUuL30Uyb7DwCAtFuU+vs0YM8FgntjJznHJrwh
 a7yVy1YWASBzb9idwFNhNPv25kchlVw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617248747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjaNSeBgfzgkuyEsWxYZoYBCpAjOIOQn7I8YDCkmDGo=;
 b=dFHb1v5tJNBcDuwHgD30UxS24ns1JuxChuII8XEY/ruQIlyJwSz/9pbrgM2pfhXjAoQXjn
 LibCuizmf5XqI/ZohoHsC2RJYba1YeqDpUuL30Uyb7DwCAtFuU+vs0YM8FgntjJznHJrwh
 a7yVy1YWASBzb9idwFNhNPv25kchlVw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-_WZtBOqQNBWu9CZNeCEYEA-1; Wed, 31 Mar 2021 23:45:45 -0400
X-MC-Unique: _WZtBOqQNBWu9CZNeCEYEA-1
Received: by mail-pg1-f197.google.com with SMTP id o9so2504766pgm.15
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Mar 2021 20:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jjaNSeBgfzgkuyEsWxYZoYBCpAjOIOQn7I8YDCkmDGo=;
 b=Dx+AhkeMlo/JHzl0zH9KMVrF3hhCoNMlOi3eAwsy3SJPy7mvwNtmOrpbWq2vDHl701
 Ees+NRUteuWGO5aa8VBX/dG9QinHEJEaIaMjGvtpMEwjHBrIvlSVoruSQ1yjcvdFK/+x
 RsUiVKqfSXP884y2SZPr11/i28TIzDUafAsk5kTzkN+lRW9t419lFDdyXQ9Dnu8C2HyS
 N8xmgZ0VX+ZerwRLIu3A+6AlcKiWZB2kZbP3p8KlcvJxnNzHOzoeAOh/Ikv0nBJIRWN6
 FXVVq34Us6d6HbP7vI+X1XB3u33LnL+WgxcAVMEy+rkejIjQBkKhD6IvgcMEtb71RmNI
 yTaA==
X-Gm-Message-State: AOAM533nwlp939teB/vLf0TwQR/1iLZo/zDV+cg9Kl4fA2YZNFTTID8M
 fVJQzhnRREf803E4W36GifRcYzFOKpq8MpWgA99wGUpX+QLFOjYRKsep6IZozUzTOc3/GYnmngp
 LreaDXnSqRf5A7lbQrFWQLBX8
X-Received: by 2002:a17:90a:6343:: with SMTP id
 v3mr6637658pjs.153.1617248744354; 
 Wed, 31 Mar 2021 20:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhbkMW5A2oZJnz4u017su9Wobd1uajyGrVAtazuw1W7uQMfatgbwuglcftS+X0YMAajTJhSw==
X-Received: by 2002:a17:90a:6343:: with SMTP id
 v3mr6637644pjs.153.1617248744148; 
 Wed, 31 Mar 2021 20:45:44 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k11sm3553600pjs.1.2021.03.31.20.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 20:45:43 -0700 (PDT)
Date: Thu, 1 Apr 2021 11:45:33 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Ruiqi Gong <gongruiqi1@huawei.com>
Subject: Re: [PATCH -next] erofs: Clean up spelling mistakes found in fs/erofs
Message-ID: <20210401034533.GA3803200@xiangao.remote.csb>
References: <20210331093920.31923-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20210331093920.31923-1-gongruiqi1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Wang Weiyang <wangweiyang2@huawei.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 31, 2021 at 05:39:20AM -0400, Ruiqi Gong wrote:
> zmap.c:  s/correspoinding/corresponding
> zdata.c: s/endding/ending
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

