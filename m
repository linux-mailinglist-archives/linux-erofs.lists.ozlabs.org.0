Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1794818C
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2024 20:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722882452;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OTuejz/vEqf2d+PXlLcHZwpW3jVv+PuTs3+Oc8ZlGpqpF44n2Yk0epgFcxc+gaYsV
	 VD0VQhHzqROgzlCfb86fYwciMGEQXbzcV2qBYfsCOvcBN3E57W8g2zpMILwJ3lNgG8
	 cS2QvAY8E8xsqwQ1/ZjpQ963ACcebAmNGPgeb36qb7WtRXb66HYXPzuoU4x/Va2ntK
	 GipXFA2i+/JFy8DVm3zBEFjvHzu/tOyPcz5R07lyTzFIWIcXy81Us5+2Iv9ppCGmgO
	 c2tUcaX6+JYIIFT/nQajfSQWz/+n9z7baKfazLKUrT65jEVy5y2uCkTPEoX3Qneqxo
	 VdU/AcKyjdh4Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wd4fr0nJ5z3cbg
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 04:27:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=jVXPk3hY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wd4fm4lDlz3cTl
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 04:27:27 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3687f91af40so6451015f8f.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Aug 2024 11:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882444; x=1723487244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=f2Ies8IiRackOoH0kWDrc35VtzDZhUJmXyx2aQv9rvuIjG7Qfu+/IU0cQ2P1mXdep4
         JlTtIMzI2vHcQ/AzJ2ktUyvW9HRiC0nhEnp7XrfiGOzXhEonVLwO0ne6++sAPC5wCZpc
         +6OQWZG8tlhYTDmvSNYsSPPD0XqryjXUQE1zyC5IuzobwK+d5yX4FE4t9Dy79lTniesV
         Sj3MKPAukzXOaM5YHzElXY7fZe+1Hu1+wd6WFVKJZlKDZVszoROgh7OC+EP6apEeQUqb
         J9VfVWlWdeqAn5Q/skWOrMQjGoRnFErNf/kac0PL0gvy1W9fKZ1nkylE777HVmD7pigx
         INAg==
X-Gm-Message-State: AOJu0Yx8yuD8pcqZPlXHiVixo6EzCoI8En/YKoart48fPPfSC/rUao5I
	G6GCreBHgeaW6QA2gcIUFZe00peb+1e+lNDFKG3Wu2UyGyKJZ72FwSAxSP14cZswJzOd/vMJRwA
	O57cdjvt2hCxCaTc+z8y8Dkk3z4GmVUbaJaQA/V0N31RxM2KLQt9uRB0=
X-Google-Smtp-Source: AGHT+IFqMLrntWNlwDRZ3LZva7yAfOPhkq0ZRTU2rd+nu2hT8ds7YZdF/ePBhdWm753yDUrhxJVb12yNA7g/S7q928Q=
X-Received: by 2002:adf:f345:0:b0:368:31c7:19dd with SMTP id
 ffacd0b85a97d-36bbc0ce408mr7531135f8f.5.1722882444024; Mon, 05 Aug 2024
 11:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240805024408.2598464-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20240805024408.2598464-1-hongzhen@linux.alibaba.com>
Date: Mon, 5 Aug 2024 11:27:12 -0700
Message-ID: <CAB=BE-RvceO_6qPaOyk6Cai-4kvc4rAoXp5eqbS+68zco_9-MA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix invalid argument type in erofs_err()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
