Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF7A14D2A
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 11:11:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFqp1ktfz3cmW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 21:11:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.58.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737108661;
	cv=none; b=TtrUGW/B+S0oXyCqm0N7rRax/S77BZRYRln2zeh9LJVgIwKef7OidT5RRVz70xMYlYGE0N/czkTQgWS281Cq6JP1SkAfslILiq5FIzTq6woqn+jjpKgsqFlYon6Jr8JsRnetpDVLTG9YTLOF6udpEssSiB2hRRoUdqF5vUKHgAvLjmc9DM5W8aMFbYW59n6Q72Eo64IdCSSv/sJwmjiE8vZoDIvh0vTm9RJsSa4IOt6NF2XS/lZA8vn8DTQIu+Y/WTBcwr4RMGIWWiw9fzhCw+bZgOX1MGcdfCkVW1eqZLyCPPHr9KaSlApMX86JSneDltLt9+Kre+ltvUI3tm/liA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737108661; c=relaxed/relaxed;
	bh=XYnUXJCZmEMh30Jfh1wM7Fr2Gx+Yg45Avih/Bn+RKHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpLAo0RdtcPFdze0cjceQ1NAluh/qgt+SZzTmLrjOv0h+4ug20uc48JMWEeaNnqMLeiSA1gxMQjgAu+xwGvqhU+ARq5Td34C9i1leBeOzHuqpuECY56qQGOC1LLAxoWpNJ4o1x1V+Wy3a+8Mv4OypA63xnpAKy+fxId+aUzJArSrFFbcAQyeHVioRU3+bygRE+r+nwwyLBQXmrWPCQ9QCdOeehwkATe5pLdQ0B0t1/ie5l4x0Nk8iCNCkmu9FotMtLPZhnxEQ6WTJGHkvIYn/YdLnF8IGck2/wk15F3sgLbO04stfwYPmLAEtoxqTw72QmeyU0dGTv4XLqDN4RaqEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=oIw9pknM; dkim-atps=neutral; spf=pass (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=oIw9pknM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFql75Hsz302b
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 21:10:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737108613;
	bh=XYnUXJCZmEMh30Jfh1wM7Fr2Gx+Yg45Avih/Bn+RKHI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oIw9pknMld2sdmlXDfMDHSzzvM2i1dmXe3vsDe2xjV0E2BeZa3X8MPUItJa+7aDEP
	 7EQokdKzzqYmqXY4X1B0/uoLqwAzR3nzax4vPl5s/pyG5TMEGD9iZQtC20/U9bjp95
	 4VsSXk+5XyEcERVZzVjCgbhX754TTidw6FH5M5Mg=
X-QQ-mid: bizesmtp83t1737108598tyu240vh
X-QQ-Originating-IP: aI/fN375D2/x29H4QtwMISkBZhVACxKYcDZA4FFS2/I=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 18:09:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15207600294287799741
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH v2] erofs: remove dead code in erofs_fc_parse_param
Date: Fri, 17 Jan 2025 18:06:36 +0800
Message-ID: <DB86A4E2BB2BB44E+20250117100635.335963-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MAMW4dxoxFyt0rzHRoajeslRwPRpyqUkOKAU/GwsY2v3wKbVZE4bQLM6
	DLmmkJJhRcDgOTwDmiP0+nQHjKT2daiRaEArzIc4maRtDuJ22EK7B1rNo3lLyHZctzmnt7d
	nDtSccefb3V34c9nMzYUd+IFHOFlhLcoDcTm/c0Eh5Oj04MoO397+UEuxxJlfz0zhUCNPAA
	6Dy0yNmtGSI+o9mr6YvzkVYSFg8W7jHnPLSfXzov5COln18jp8xz8+AeaCp17Ub5x1LOh3z
	3Yah5FMisS98h8nv/IQ5uCn8iI5bGHyGH2nJSIScAnSq1nuAg70B5qXGkDzrIg4gQtnc4A1
	f0SK1pJkzH0hJcJtdzf8iq/D4Kx6+0mU+jCeQaU/QkDd43NK75JHDsrF+Vj15FtxvqPnjFj
	nPzBnTYCTHGX57K+aMzl4dKlGygbYtsXRSiTQ3j7Y+RPdbwrcifuwyVVSMNqjxB1Flqq8HZ
	G29zjC+MK1BUS43wnMngnNrJmwn0lVvL7LZA8T/+Bsb62PdWQcm5hLAz38EzOx4ums0q+9A
	qvzMfusmMpGoI1evxqZUMCl3ssv7DnIsvxpIE5hAjADaSQxsWOCuDCLP8xjB204LCSICbUj
	TiR9oVinU9WNutpFq45a/79L57zSazTIM+UlDPVj7xQCyEiAR2geQ8/uTUVskfnuJtMp7YI
	wI1s6hDmh468Sof5aV1lsHJ5sHO2tfc7bkFHRBW9D5XUWdwAKYP1WFTUtFposgWW6q2KEvm
	Fzx7W/ThS0Df/S2CRRA2PE8lYBWlenaOy3qV38hjYYB7q9coNIkkqaJda18hEI/OKrKoJhK
	/UGfUKBrl0cmPt56sdnXl7t2C9qh6KDzLxe9Pl7UcScyL8XsP6xg33TwnRACEpU53DHqcbE
	Rl00RFhimbdhAP23p7qAhGBwhO+NMfNRSRBAmATtI0mtJ1Xi1NoYGL9lT+M4Tn1Jf7QHoWi
	HgrUVUiAFvBdk88FEuVCPG5Q5zyw7Z1e8xm41kimtLvY1xUdNMYmhSjwW9sSU0aa2toY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org, Chen Linxuan <chenlinxuan@uniontech.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If an option is unknown to erofs, which means that option is not in
`erofs_fs_parameters`, `fs_parse` will return -ENOPARAM, which makes
`erofs_fc_parse_param` returns earlier.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Change Log:
v1->v2: Improve "erofs: add error log in erofs_fc_parse_param"
---
 fs/erofs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1fc5623c3a4d..827b62665649 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -508,8 +508,6 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
-	default:
-		return -ENOPARAM;
 	}
 	return 0;
 }
-- 
2.43.0

