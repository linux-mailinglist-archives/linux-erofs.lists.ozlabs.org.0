Return-Path: <linux-erofs+bounces-587-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2BB02184
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 18:18:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdxj43S1qz30Ql;
	Sat, 12 Jul 2025 02:18:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752250712;
	cv=none; b=C+SQfe1QhzTuEy82C5Hk/qkyX2VBg659oww1a6VJcJOTvRKX+W1RIv96/IB6fIPJLbnf5zyEIKikHYZqMauuRx2QqMSAb1qrbXvpT7q1un9RaIXKEgh8RsanUgVH5x+guQjCehZBowAQutdQ+wgNSHgupTitM2MsqCJKemx1fctLRNraPje6JuCXVl6ETdqnJxQ4XLNTlODPnQ4ZEBtPsdhY2ztzpd838Fb5N/0ULxfTkK3+4VDZz7a8qN7XZ2DMpIkkVS/DtU4JbMzdprBkhzu3a8hyr8lfWQEN5MKIBRI2avvAk122yFIQfBnjCQgEgXlOtZeDSXVk8Wmoztfy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752250712; c=relaxed/relaxed;
	bh=YplC3WX8IGDrRkEWTPPG3h5niVRcw4UIj5e45e6mf2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx5wwDP67Zf066J+nBr9gPrdD8z0xMHMWGNMVlFztkKbMWjIjsgMLvNb87lDIVTT1Shw66y+45z7oCNHTjp3kw4Zh/7oLpbmfiXNuh4NycjeGcE6MtTEaxVShCxtY35bVuX/iUBx2IO2Lvthq46js9cLrVgB9+4HST7LquU9hLMubhDlyJ9viJ1D0baPlx1cwSEWj5X97vPwoVI8lEkJw6sA+GyJ4eD6Ew3eZLJuJokL7nXTEJMQ6IRxS99rMkgfwV0HiKM5VeUZ+dfRonBpRuxTtDjB33SK68a5Ey9pxSpUeLcbXVpw5mjjQy+IKNvChcitlJYjD5madz/ReIYK0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=APeUzwUC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=APeUzwUC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdxj35SQfz2xfB
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 02:18:31 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2034425b3a.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250708; x=1752855508; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YplC3WX8IGDrRkEWTPPG3h5niVRcw4UIj5e45e6mf2I=;
        b=APeUzwUCt7LQq+7EqMQ5zEs2M8mbL3roSHyr/f0EbdRHCZga8wqUKbUXuX9Ci+VcFp
         OKMqg8K03XLJ4x69ZxFRg5s55dB9CdaXYzJsda6nKAfGi449KKhitfi3Gq0H/otKPlcn
         KgGxVM7WZsd94bqppV6WNReHcqWuefEizYBZ4PpvjfyQ85L21ZUPzk7RuL4h4ildp40p
         HkQYu0LoHY5lpDwOES/RC9kidME7sAR4qhruRQp+wwxfOyp86iyzurVh5S+C48Dizy9Q
         QuFd7KOasG+AQR+Ecz+WJkq6ANpijX15MoM/EEtL8a2v7YxUwqGlHeQnKULeTONzvH29
         v0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250708; x=1752855508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YplC3WX8IGDrRkEWTPPG3h5niVRcw4UIj5e45e6mf2I=;
        b=OFEmGQvNPMe40cL8KTus47kJ8AnO2+6slVUw7JxmGuovc0dTErW4fT6584e4F726Y4
         6G/5uSPnqD4VAx2AYfCQnSQLImJC90g907b2hFYWeSQI0eF1Pdmc7IBAG3BXzORl5Lvd
         i0bqTi+c4Q0UKzVNz9+JF7bfWWnF3NfACRhF6ZIeWj+UEGvpBlBvL+DrPVBH8wqqvidq
         G7/37FzOmgadQRWc0ge4g/J/iBS+EJrev8PBsl05BzrAWYAkaOmQf9VIs5rZROp/h5vz
         +nwMmA5Tnq/xJWZtpuracDCPwWNdaZ7DrUWSCau2QMZNC/qyZsmlqK8S0cOL6Imztnfh
         FIQA==
X-Gm-Message-State: AOJu0YxB9rkmKJ7hnrcY70I+h0Z5uvV3EkWPCgsR5IwWitjHTLGn98Wj
	YlwEtMVgmXddt3P3ciPKOHnmeA+9405v1a2WC2G5tYoC+JAuwcZzAh1aQau1gFDR0ks=
X-Gm-Gg: ASbGncvxMuVLl3nwS2nlUWS3GWcTFdbJFDXTimqUIeTWncCEEgir/IMiqjSxILbfaMM
	kYK3Sp7Jld37z1brSsK7dGaMWIdqxBWuldBgxzNWSOd1627HHJ7qKMwyV9gRY+qDkx5Ei+8MLOQ
	UDl8QV7unbE0ikkb5Ez8JDC7C12LhW9jr4hKmr9Whlui2tvJgcmtBg4KwVEmZAFwdu1lbyfpnmD
	JRh/BrgeS4oR1VD2jPPb6xV8O6OD8Aw8vY+bs55lCt7SsM8pVdnVR6W5a8zmshwdMy9c7b7W+ZG
	WW3z+IYGBTF65gUOR+cslxbMbqJ38nlJ2Vc5o3bdOZOSdmZ8jxTqfSwjtLblHALj74nEbRyQvQ7
	7E4H65vimwc+PKULQoD6acLZHoka5rUHsIlbpgbg=
X-Google-Smtp-Source: AGHT+IGIWz4ZXjasiTdxLt9zZtscrIlXlNBt7SrxCJh/42WcqY1b+yfAgCyN52bCWD651XdN9RsMyQ==
X-Received: by 2002:a05:6a00:3981:b0:748:2d1d:f7b3 with SMTP id d2e1a72fcca58-74ee2d4ef5dmr4225361b3a.22.1752250708263;
        Fri, 11 Jul 2025 09:18:28 -0700 (PDT)
Received: from ZYF-PC.localdomain ([112.64.104.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e075e2sm5865280b3a.52.2025.07.11.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:28 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH 0/2] two minor fixes for erofs-utils lib
Date: Sat, 12 Jul 2025 00:16:13 +0800
Message-ID: <20250711161615.44832-1-stopire@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Fix following issues during basic usage of `mkfs.erofs`.

Yifan Zhao (2):
  erofs-utils: lib: fix uninitialized variable access in bmgr
  erofs-utils: lib: add guard clause for z_erofs_compress_init

 lib/cache.c    | 1 +
 lib/compress.c | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.43.0


