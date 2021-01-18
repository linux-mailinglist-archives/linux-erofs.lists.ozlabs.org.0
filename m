Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A782FADBE
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 00:29:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKSft4TJ2zDqnV
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 10:29:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SuAiJN2E; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SuAiJN2E; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKSfk23dVzDqkd
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 10:29:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611012550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+5kSqSLnA/Y7J0LMV9jMrQF2DDJknQH3n/H0anfJzg=;
 b=SuAiJN2E7j+jbKmDayOFlrQfyp/pbcMJK8cc1Df4HDzcXyjuJKVoGU2zaoJTkUueSvsHQ7
 PRUU+y9nM2sLcxG+2eqtdwHCMR1OWFBmqwsSw52E912CtSV0pJz06IXO3xlCF77Bq7Up0H
 3AWu7RyyGGDUkl0L366UtA+eaJveWaU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611012550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+5kSqSLnA/Y7J0LMV9jMrQF2DDJknQH3n/H0anfJzg=;
 b=SuAiJN2E7j+jbKmDayOFlrQfyp/pbcMJK8cc1Df4HDzcXyjuJKVoGU2zaoJTkUueSvsHQ7
 PRUU+y9nM2sLcxG+2eqtdwHCMR1OWFBmqwsSw52E912CtSV0pJz06IXO3xlCF77Bq7Up0H
 3AWu7RyyGGDUkl0L366UtA+eaJveWaU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-fFeaCcw2PBKc2fjlBo6IaA-1; Mon, 18 Jan 2021 18:29:05 -0500
X-MC-Unique: fFeaCcw2PBKc2fjlBo6IaA-1
Received: by mail-pl1-f197.google.com with SMTP id w22so8537966pll.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 15:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=9+5kSqSLnA/Y7J0LMV9jMrQF2DDJknQH3n/H0anfJzg=;
 b=mn9qaWwxkDkgPEZ9AxpYzzRkP4IlJontYoK/qKTDiwMEk+SzfNCNn0uy/Y0YvlhyYN
 CZRx6b5QrOjG89Ms2MbSGYlFmXvdVDwTqKJjQffVDLGz7hvnnkIpzcr8v/G0S1AZRVSm
 5vvpKE42F0KGBoq296inccSwWyQYAQGlZwPFzakZHw1STbBeytIFBEhRIdpBrnJwDBqy
 7CoFjabH6O6rGhz1VZ3cWz1Bp/frcX72GgNqEVFlKMdCzCvnv626GpLm/bf/QQbjvuwf
 nXJGH8cKMi4FltMgx/3l4hviEwUAQtZyWn/NFyuEeImfr5Ghg3+U7rL1rN9KXft2qPoX
 uaWg==
X-Gm-Message-State: AOAM531m3V794vM6WINfcueKFlxBOZx2wvqyYzMrO/p7m6w2JOcgP2xX
 b63K7P5kL57djaJ8g9vRVQ4BGSiGErHSR5Ij0RBJAUy7LvMhy4nzanDD+NHjaIxKChoUmjhCnX4
 uKa30gC+cY3XN0yfnc+DQeqNs
X-Received: by 2002:aa7:951d:0:b029:1b7:7719:765b with SMTP id
 b29-20020aa7951d0000b02901b77719765bmr1637470pfp.69.1611012544196; 
 Mon, 18 Jan 2021 15:29:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPkEcQGkv06JokgRxmeamk9wRHACoxD3G5ugCg57glmvO+atdBwiawdoT/tRZvJYnTc6O1rg==
X-Received: by 2002:aa7:951d:0:b029:1b7:7719:765b with SMTP id
 b29-20020aa7951d0000b02901b77719765bmr1637446pfp.69.1611012543775; 
 Mon, 18 Jan 2021 15:29:03 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o10sm4524709pfp.87.2021.01.18.15.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 15:29:03 -0800 (PST)
Date: Tue, 19 Jan 2021 07:28:53 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210118232853.GA2490678@xiangao.remote.csb>
References: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
 <20210118135916.GB2423918@xiangao.remote.csb>
 <20210118155205.GA21706@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
In-Reply-To: <20210118155205.GA21706@DESKTOP-N4CECTO.huww98.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 18, 2021 at 11:52:05PM +0800, 胡玮文 wrote:
> Hi Xiang,
> 
> I would like to. If I understand it correctly, tests should based on
> experimental-tests branch, and be submitted to this mail-list, too?
> 
> I wonder if we already have some CI service set up to run these tests
> automatically? I saw a mail from Travis CI in the mail-list archive, but it
> seems I don't have access to that organization.

A travis CI was once used for avoiding erofs-utils build regression...
I haven't set up a CI to run such regression tests (since it's still
in experimental branch...). Also, it seems that travis CI.org will
be obsoleted in the near future, and I'm not sure if I like
travisCI.com... Therefore, github action would be better (recently
I tried to autobuild erofs-utils deb by using github action and it
seems fine... will investigate to automaticly run regression tests
when I have extra free slots...)

Thanks,
Gao Xiang

