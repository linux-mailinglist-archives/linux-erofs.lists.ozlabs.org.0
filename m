Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D6444C4B1
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 16:52:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hq8WP3Yy3z2yZf
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 02:52:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636559569;
	bh=ZCpQjrq7C3hg0Cn73eqdJYlp2IX9NX1xQ3haVauKyLo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mlkG1MS5hUKj6LXsnCADwuUrIqR2nJPxujm88J7TyN8LgxsFeG/8qkDcbDNilgr/u
	 2+Xz2dOY1peI74Ojd7Gn85DLLFxoMw7pZNeiFscNQbZIPZK2cu88u1hdsgOPw/ujys
	 uyECSu3y+hP2cUaiVsI46aGjFzKjd+UKg694kjKV4voSUMtQoiU/7Jmjj8beVIy6RG
	 uqVw3XzjPS5n490R0Nd8bUlqvGz8pEx5Kkp+sfydhzsU/O7HyT8+xvXc2giTe6BbHU
	 tCdwEKSad/cTIsKnCW6+t7FQ/mA3utXUTo6MUoJPC09DOF91sxSpiPIyGe9CvKx+ol
	 +uPMWlIe/x/Xw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::32f;
 helo=mail-ot1-x32f.google.com; envelope-from=daehojeong@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=TopZvhW9; dkim-atps=neutral
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hq8WJ0HnGz2yPj
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 02:52:41 +1100 (AEDT)
Received: by mail-ot1-x32f.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso4495658otj.11
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 07:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZCpQjrq7C3hg0Cn73eqdJYlp2IX9NX1xQ3haVauKyLo=;
 b=y9cdJXK/o0cH2lLT0qUTKxlgpOfS4ROIIA1WwOTeCChkKRi/5S9LAjgoTLoO0tAaBO
 XGFB3MmKPp9dPjZ6SJKWe/ajqMqf7MfrMPWoIw0EAXNajSl/q6D+8DOxMNZkkwHxfJw4
 BtanCbjOcUIKYqVACUTsw+xM84OtFm4AV+40XDMT3uvlCRXUi6GflioI0V9OkuaZIiS6
 iak5UXzHJZoDYllx87B3BupfFYDmAaBvQZAogtKsdYkRtyIMl0MCGlvp+bsqPTENmBnh
 6sHqZrHzKzYkgeFDUplLDebYVrd3Nq9HPH1XAvMH6/vJp9pm+YrztEJd5yiWhLdpzMRH
 vn7g==
X-Gm-Message-State: AOAM531lOArRQhGodRKbj1gDIXzIIlzXQlIdJOkP3P9lhwN/l+fvSKbo
 R2QiE65qYxE9tJbGa9LymZSBwoGpjgXsJwqtpj0dDL7nSX8=
X-Google-Smtp-Source: ABdhPJzWlHpC4dIOJB07szA6dMhDAouDei4t5XwbqTojKfU0Yom1gbA27cizvI1OVy0K2SdSagSSZUMUx+j9vtf0W/A=
X-Received: by 2002:a05:6830:1e25:: with SMTP id
 t5mr170397otr.291.1636559557893; 
 Wed, 10 Nov 2021 07:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20211110064931.181727-1-hsiangkao@linux.alibaba.com>
 <20211110175136.00005c5c.zbestahu@gmail.com>
In-Reply-To: <20211110175136.00005c5c.zbestahu@gmail.com>
Date: Wed, 10 Nov 2021 07:52:01 -0800
Message-ID: <CABdZyezDdJuYH+cZjhUTMuhDwXKjSpHSe1som5VOn1Lid846Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] AOSP: erofs-utils: avoid lzma inclusion when liblzma
 is disabled
To: Yue Hu <zbestahu@gmail.com>
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
From: Daeho Jeong via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Daeho Jeong <daehojeong@google.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks for the patch!
