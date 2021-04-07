Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B5356216
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 05:46:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFVg328yFz302b
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 13:46:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.79; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
X-Greylist: delayed 430 seconds by postgrey-1.36 at boromir;
 Wed, 07 Apr 2021 13:46:04 AEST
Received: from smtprelay.hostedemail.com (smtprelay0079.hostedemail.com
 [216.40.44.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFVg04Mpjz2yRK
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 13:46:03 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id A59091802CCBA
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 03:38:54 +0000 (UTC)
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8704E181D337B;
 Wed,  7 Apr 2021 03:38:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf15.hostedemail.com (Postfix) with ESMTPA id 6CCE6C4182; 
 Wed,  7 Apr 2021 03:38:47 +0000 (UTC)
Message-ID: <b56a44542a338583279893870ec819d4b1b4e23b.camel@perches.com>
Subject: Re: [PATCH][next] erofs: fix uninitialized variable i used in a
 while-loop
From: Joe Perches <joe@perches.com>
To: Gao Xiang <hsiangkao@redhat.com>, Colin King <colin.king@canonical.com>
Date: Tue, 06 Apr 2021 20:38:44 -0700
In-Reply-To: <20210406235401.GA210667@xiangao.remote.csb>
References: <20210406162718.429852-1-colin.king@canonical.com>
 <20210406235401.GA210667@xiangao.remote.csb>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: ofx9em7xwsozzieswcpenrt3r3r95cat
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6CCE6C4182
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19GKTF9FPXA2XYpIjjRK9qyadDR5X8MmkM=
X-HE-Tag: 1617766727-223981
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
Cc: kernel-janitors@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2021-04-07 at 07:54 +0800, Gao Xiang wrote:
> Hi Colin,
> 
> On Tue, Apr 06, 2021 at 05:27:18PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The while-loop iterates until src is non-null or i is 3, however, the
> > loop counter i is not intinitialied to zero, causing incorrect iteration
> > counts.  Fix this by initializing it to zero.
> > 
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: 1aa5f2e2feed ("erofs: support decompress big pcluster for lz4 backend")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thank you very much for catching this! It looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
> 
> (btw, may I fold this into the original patchset? since such big pcluster
>  patchset is just applied to for-next for further integration testing, and
>  the commit id is not stable yet..)
> 
> Thanks,
> Gao Xiang

I think this code is odd and would be more intelligible using
a for loop like:
---
 fs/erofs/decompressor.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 27aa6a99b371..5a64f4649414 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -286,28 +286,24 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	}
 
 	ret = alg->prepare_destpages(rq, pagepool);
-	if (ret < 0) {
+	if (ret < 0)
 		return ret;
-	} else if (ret) {
+	if (ret) {
 		dst = page_address(*rq->out);
 		dst_maptype = 1;
 		goto dstmap_out;
 	}
 
-	i = 0;
-	while (1) {
+	for (i = 0; i < 3; i++) {
 		dst = vm_map_ram(rq->out, nrpages_out, -1);
-
+		if (dst) {
+			dst_maptype = 2;
+			goto dstmap_out;
+		}
 		/* retry two more times (totally 3 times) */
-		if (dst || ++i >= 3)
-			break;
 		vm_unmap_aliases();
 	}
-
-	if (!dst)
-		return -ENOMEM;
-
-	dst_maptype = 2;
+	return -ENOMEM;
 
 dstmap_out:
 	ret = alg->decompress(rq, dst + rq->pageofs_out);

