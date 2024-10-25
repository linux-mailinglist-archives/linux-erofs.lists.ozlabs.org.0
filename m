Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08F9B0BE1
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 19:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729878097;
	bh=EcQEvJrgz/ZBYbRWUWCni6pAoEb+qAvjeOu7SpnP/EQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=johcTE5IIZdVl4d2WlhMig3L4TCg/0MjetaQpajkfJ3luMg3VDpdkhLpgHynCbYeP
	 fgutEZKGkqNo/JntJ01c4PWoDgluIfDrXHWskp91rtbHoZ7PnqKC/2ucSIkjljef64
	 Li7BtADWkq/w70KkeaWMjxMHGl6ndWh8uqrKIos+xh1oQuYZlgSGBlJpQIVj7bBijB
	 redi8bzJhgYAzJ0umzp7JZchuGxRABoa5rbl38oC6UUJTiP4A3/zl6QN3qrKUbaNcm
	 lAXjyi9dZaSJn86GnsKaK+12YnCreuDy2jtqQp6y+DzzRRCeUeT24mYtvdDbKXrHNN
	 bSyQOuSJAyptw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZqpT3lfmz2y8f
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 04:41:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729878095;
	cv=none; b=CgIYD81+cYqVejLirIs2rMHzZBf/WQA/oO4oUUH/ZklK26VBw9Bekaqo4SjkJHekhwAUObfkR9cWLilPn7PuQmHQjoD75bmnjMBAtAX3url8jkfwsk0uhmPgyfejgX3J5qAK3rh4Z+obgjVpv36Z6pTbqs2w5mB5ckQn34phKNB3d69dJ1PBz0a4NJ3jo+ojSNMA1C6GQ7/JVS5EeE5u4TCKSc0UfHINBt0MaTm/lB0AEvEGb5AdKzwETydaDk/UgSmDqT8vAmR8uJwDv69jzVHh80yTZCoGT7xSwYjIEQl+nSD9sjC4U2WsslZNMRoeueHCTGtogz5b4Jhd4PVDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729878095; c=relaxed/relaxed;
	bh=EcQEvJrgz/ZBYbRWUWCni6pAoEb+qAvjeOu7SpnP/EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlN+Ey6Co52oyE9bQrpskemZ0RRncvcRAZFWHasbR+hqC8BCezS4d8kLgR8iUEGjtmPxe+Coz7euL0yghGNkP48cCRnRHlLIQOfY0zt4Bl0fpkV8zLnMJ7SBZ+I+iICLJZVVJT+Z4svqzy+2ALgYXzwvQYGZztuFEtmlVB/zbV9mlWfMrH+DUFHwh6Jvra27S9/cqH1Ex+98yhaj8MumceuhIa8tC16rfFX06uGiykW6wYId7auViQMsDlyXwLC4rbAC9KOlpjKviIilscy6jNlNHypy+Cx66OI5/AdiuNlGchIxKnTx+HaXGxeUaqVTIr9Pzr6B735gq3RQu8kK/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=uU4DSadq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=uU4DSadq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZqpP5mbYz2y8f
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 04:41:32 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1789529b3a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729878088; x=1730482888; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcQEvJrgz/ZBYbRWUWCni6pAoEb+qAvjeOu7SpnP/EQ=;
        b=uU4DSadqXmKjoHnzwOyRCYWVCw/2s5gkncDD6Mc2lcspdSZQIsOqV3QLnazrL8fa7S
         tUqgwvn4ha0padPzH+2ZJyino2X+LP0WFufPBjbJiFPAynldhTtQy8OIVlDhLQqKzmIw
         3PylnKLSfwZL6fXj9KdqMxf+u7dmos7RqzDMWNoPOkusAjFtZsnH522sqKcVTiH8rXYZ
         qZfVuFXKULXSWFFByEEeRrwqKH57W85QM/kheMrddGZRidRvY3rwAaiyg/zQpKQ+ESn2
         V/9Re5ZNoYBzZvV0SFkQKEZVksOWwyP5A+JQ2nX1Q1XDkU5CNbWW4TJWqLJEslB2MJ/A
         CHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878088; x=1730482888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcQEvJrgz/ZBYbRWUWCni6pAoEb+qAvjeOu7SpnP/EQ=;
        b=if17HECW0M2OrSEj178LDIxRPiqLsqvLLOH/85GpCIx9ubCV6tREhQy10htPEo7e81
         0USEHYuruuJawFQd/gz4XeKaV+Dw8VcYwxmZMu5UQZJd/X9VGDmAsN8e97NLYsvfysrs
         8ofn2snw3GVKysTYIbstKTb/As1xe7BFPfYEzvT7m8iEQI6CT7tLVb6b5T9wWyl/N/52
         p5idVI5Yqz0WInYo4lZ3O07tfTUf1he31e+VAKYTbUuSb57rVsCIqq8JNliCsepDDugV
         8yFUoGA1Nmiwy28h+yMpuUCMoQSMpT+uWHEFRuJaR2DNUGO6fi203bS5tQx/uGslX7fd
         sKKw==
X-Gm-Message-State: AOJu0YzJl+9GNS/61crURmanHnTQgJx3inRslWstf1psvMXwygzFtYh5
	00J+S/kt9k2UHcNxXAvTYArEM5g9AOCFrSQhf3h+yI81qZvEDSeXyda3VatzSlVIpA/oRI7muXG
	5dmiGnB746a/WCPKtrYnnbtDQa5I3fU1n8hVA
X-Google-Smtp-Source: AGHT+IGWW+cPzcj6SBWwoVWTZC6A4WH2jAqQUebleJPG07hupu0woyrS0zQPJOe4zgFf1aLaHtgHrhC/ychGU+L1hGo=
X-Received: by 2002:a05:6a00:1303:b0:71e:4df3:b1d3 with SMTP id
 d2e1a72fcca58-72062f80b4cmr587374b3a.4.1729878087883; Fri, 25 Oct 2024
 10:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241025015246.649209-1-huangjianan@xiaomi.com>
In-Reply-To: <20241025015246.649209-1-huangjianan@xiaomi.com>
Date: Fri, 25 Oct 2024 10:41:15 -0700
Message-ID: <CAB=BE-R4MuyEw2VYM3jgMWQeBdSOKTLcV1XXDvfQ+LPJb-YG7w@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: avoid allocating large arrays on the stack
To: Jianan Huang <huangjianan@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: zhaoyifan@sjtu.edu.cn, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Looks good to me.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
